//
//  FacilityModel.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

struct Facility: Codable {
    let facilityId: String
    let name: String?
    let options : [FacilityOption]
}

struct FacilityOption: Codable {
    let id: String
    let name: String
    let icon: String?
}

struct Exclusion: Codable {
    let facilityId: String
    let optionsId: String
}

struct FacilityResponse: Codable {
    let facilities: [Facility]
    let exclusions: [[Exclusion]]
}


extension FacilityResponse {
    static var example: FacilityResponse {
        FacilityResponse(facilities: [Facility(facilityId: "1", name: "Property Type", options: [FacilityOption(id: "1", name: "Apartment", icon: "apartment")])], exclusions: [[Exclusion(facilityId: "1", optionsId: "4")]])
    }
}

