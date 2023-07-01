//
//  FacilityModel.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

struct Facility: Codable {
    let facilityId: String
    let name: String?
    var options : [FacilityOption]
}

struct FacilityOption: Codable {
    let id: String
    let name: String
    let icon: String?
    
    var disable: Bool? = false
    var selected: Bool? = false
    
    var isDisabled: Bool {
        return disable ?? false
    }
    
    var isSelected: Bool {
        return selected ?? false
    }
}

struct Exclusion: Codable {
    let facilityId: String
    let optionsId: String
}

struct FacilityResponse: Codable {
    var facilities: [Facility]
    let exclusions: [[Exclusion]]
}


extension FacilityResponse {
    static var example: FacilityResponse {
        FacilityResponse(facilities: [Facility(facilityId: "1", name: "Property Type", options: [FacilityOption(id: "1", name: "Apartment", icon: "apartment")])], exclusions: [[Exclusion(facilityId: "1", optionsId: "4")]])
    }
}

