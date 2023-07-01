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
                    
                    toggleOption(for: tempExlusions)
                }
            }
        }
        
        self.didChangeDataSource?()
    }
    
    private func toggleOption(for exclusions: [Exclusion]) {
        guard var result = result else { return }
        
        for (_, exclusionToBeToggled) in exclusions.enumerated() {
            for(index, facility) in result.facilities.enumerated() {
                for(optionIndex, option) in facility.options.enumerated() {
        
                    if (facility.facilityId == exclusionToBeToggled.facilityId && option.id == exclusionToBeToggled.optionsId) {
                        result.facilities[index].options[optionIndex].disable = !option.isDisabled
                        result.facilities[index].options[optionIndex].selected = false
                    }
                    
                }
            }
        }
        
        self.result = result
        
    }
}
