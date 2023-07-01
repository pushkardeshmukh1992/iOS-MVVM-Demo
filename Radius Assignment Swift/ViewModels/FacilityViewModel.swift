//
//  FacilityViewModel.swift
//  Radius iOS Assignment
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import Foundation

class FacilityViewModel {
    private(set) var result: FacilityResponse?
    private let service: FacilityNetworkServiceProtocol
    
    var didChangeDataSource: (() -> ())?
    var loadingFacilities: ((Bool) -> ())?
    
    init(service: FacilityNetworkServiceProtocol = FacilityNetworkService()) {
        self.service = service
    }
    
    func getFacilities() {
        loadingFacilities?(true)
        
        service.getFacilities(objectType: FacilityResponse.self) { [weak self] result in
            switch result {
            case let .success((response)):
                self?.result = response
                self?.didChangeDataSource?()
            case .failure:
                print("handle error")
            }
            
            self?.loadingFacilities?(false)
        }
        
    }
    
    private func optionUpdate(toUpdate option: FacilityOption, from facility: Facility) {
        guard let result = result else { return }
        
        self.result?.facilities = result.facilities.map { tempFacility in
            var mutableFacility = tempFacility
            
            let options = tempFacility.options.map { tempOption in
                var mutableOption = tempOption
                
                if (tempFacility.facilityId == facility.facilityId && tempOption.id == option.id) {
                    mutableOption.selected = !mutableOption.isSelected
                }
                
                return mutableOption
            }
            
            mutableFacility.options = options
            
            return mutableFacility
        }
    }
    
    func addOrRemoveFacilityOption(option: FacilityOption, from facility: Facility) {
        optionUpdate(toUpdate: option, from: facility)
        
        guard let result = result else { return }
        
        let exclusionEntryToBeSearched = Exclusion(facilityId: facility.facilityId, optionsId: option.id)
        
        for (_, outerExclusion) in result.exclusions.enumerated() {
            for (index, exclusion) in outerExclusion.enumerated() {
                if (index == 0 && exclusion.facilityId == exclusionEntryToBeSearched.facilityId && exclusion.optionsId == exclusionEntryToBeSearched.optionsId) {
                    var tempExlusions = outerExclusion
                    tempExlusions.remove(at: 0)
                    
                    for (_, exclusionToBeDisabled) in tempExlusions.enumerated() {
                            print(exclusionToBeDisabled)
                            // TODO: Search found. Now disable its mapped entry
                            
                            self.result?.facilities = result.facilities.map { facility in
                                var mutableFacility = facility
                                
                                let options = mutableFacility.options.map { option in
                                    var mutableOption = option
                                    
                                    if (facility.facilityId == exclusionToBeDisabled.facilityId && mutableOption.id == exclusionToBeDisabled.optionsId) {
                                        
                                        
                                        mutableOption.disable = !mutableOption.isDisabled
                                        mutableOption.selected = false
                                        print("found option to be disabled", mutableOption)
                                    }
                                    
                                    return mutableOption
                                }
                                
                                mutableFacility.options = options
                                return mutableFacility
                            }
                        
                    }
            
                    
                    
                }
            }
            
        }
        
        self.didChangeDataSource?()
    }
}
