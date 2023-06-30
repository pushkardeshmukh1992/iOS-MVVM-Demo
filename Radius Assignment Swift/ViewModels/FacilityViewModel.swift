//
//  FacilityViewModel.swift
//  Radius iOS Assignment
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import Foundation

class FacilityViewModel {
    private(set) var result: FacilityResponse?
    
    var didChangeDataSource: (() -> ())?
    
    private var service: FacilityNetworkServiceProtocol
    
    init(service: FacilityNetworkServiceProtocol = FacilityNetworkService()) {
        self.service = service
    }
    
    func getFacilities() {
        service.getFacilities(objectType: FacilityResponse.self) { [weak self] result in
            switch result {
            case let .success((response)):
                self?.result = response
                self?.didChangeDataSource?()
            case .failure:
                print("handle error")
            }
        }
        
    }
    
    private func optionUpdate(toUpdate option: FacilityOption, from facility: Facility) {
        guard let result = result else { return }
        
        self.result?.facilities = result.facilities.map { tempFacility in
            var mutableFacility = tempFacility
            
            let options = tempFacility.options.map { tempOption in
                var mutableOption = tempOption
                
                if (tempFacility.facilityId == facility.facilityId && tempOption.id == option.id) {
                    mutableOption.selected = !(mutableOption.selected ?? false)
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
                    
                    let optionToBeDisabled = outerExclusion[index + 1]
                    // TODO: Search found. Now disable its mapped entry
                    
                    self.result?.facilities = result.facilities.map { facility in
                        var mutableFacility = facility
                        
                        let options = facility.options.map { option in
                            var mutableOption = option
                            
                            if (facility.facilityId == optionToBeDisabled.facilityId && option.id == optionToBeDisabled.optionsId) {
                                mutableOption.disable = !(mutableOption.disable ?? false)
                            }
                            
                            return mutableOption
                        }
                        
                        mutableFacility.options = options
                        
                        return mutableFacility
                    }
                }
            }
            
        }
        
        self.didChangeDataSource?()
    }
}
