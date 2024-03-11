//
//  Network Manager.swift
//  DZ KODE BackEnd
//
//  Created by Artem Elchev on 11.03.2024.
//

import Foundation

enum SensorError: Error {
        case noData, networkError, decodingError, timeOut
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchSensorData(timeout: TimeInterval?,
                         completion: @escaping (Result<[SensorData], SensorError>) -> Void) {
        
        let workItem = DispatchWorkItem {
                completion(.failure(.timeOut))
            }
        
        guard let timeout else {
            DispatchQueue.global().asyncAfter(deadline: .now() + (timeout ?? 0), execute: workItem)
            return
        }
        
        URLSession.shared.dataTask(with: Link.allSensors.url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.networkError))
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pollResult = try decoder.decode(PollResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pollResult.data))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
}

//MARK: - Link
extension NetworkManager {
    enum Link {
        case allSensors
        
        var url: URL {
            switch self {
            case .allSensors:
                return URL(string: "url")!
            }
        }
    }
}
