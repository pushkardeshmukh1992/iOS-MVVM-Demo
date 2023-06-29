//
//  FacilityViewModel.swift
//  Radius iOS Assignment
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import Foundation

class FacilityViewModel {
    private(set) var result: FacilityResponse?
    
    func getFacilities(completion: @escaping(FacilityResponse?) -> Void) {
        guard let url = URL(string: APIConstants.APIEndPoint) else { return }
        
        Task {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try decoder.decode(FacilityResponse.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.result = response
                    completion(self?.result)
                    
                }
            } catch {
                print(error)
            }
        }
    }
    
}
