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
        FacilityResponse(facilities:
                            [
                                Facility(facilityId: "1", name: "Property Type", options:
                                        [
                                            FacilityOption(id: "1", name: "Apartment", icon: "apartment"),
                                            FacilityOption(id: "2", name: "Condo", icon: "condo"),
                                            FacilityOption(id: "3", name: "Boat House", icon: "boat"),
                                            FacilityOption(id: "4", name: "Land", icon: "land")
                                            
                                        ]),
                                Facility(facilityId: "2", name: "Number of Rooms", options:
                                        [
                                            FacilityOption(id: "6", name: "1 to 3 Rooms", icon: "rooms"),
                                            FacilityOption(id: "7", name: "No Rooms", icon: "no-room")
                                        ]),
                                Facility(facilityId: "3", name: "Other facilities", options:
                                        [
                                            FacilityOption(id: "10", name: "Swimming Pool", icon: "swimming"),
                                            FacilityOption(id: "11", name: "Garden Area", icon: "garden"),
                                            FacilityOption(id: "12", name: "Garage", icon: "garage")
                                        ])
                            ],
                         
                         exclusions: [
                            [
                                Exclusion(facilityId: "1", optionsId: "4"),
                                Exclusion(facilityId: "2", optionsId: "6")
                            ],
                            [
                                Exclusion(facilityId: "1", optionsId: "3"),
                                Exclusion(facilityId: "3", optionsId: "12")
                            ],
                            [
                                Exclusion(facilityId: "2", optionsId: "7"),
                                Exclusion(facilityId: "3", optionsId: "12")
                            ]
                         ])
    }
}

