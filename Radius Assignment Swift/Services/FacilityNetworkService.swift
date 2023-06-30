//
//  FacilityNetworkService.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 30/06/23.
//

import Foundation

protocol FacilityNetworkServiceProtocol {
    func getFacilities<T:Codable>(objectType: T.Type, completion: @escaping(Result<T?, Error>) -> Void)
}

class FacilityNetworkService: FacilityNetworkServiceProtocol {
    func getFacilities<T:Codable>(objectType: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let url = URL(string: APIConstants.APIEndPoint) else {
            completion(.failure(NSError()))
            return
        }
        
        Task {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try decoder.decode(objectType.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    guard let _ = self else {
                        completion(.failure(NSError()))
                        return
                    }
                    
                    completion(.success(response))
                }
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
    }
}
