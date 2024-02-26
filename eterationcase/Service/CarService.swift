//
//  CarService.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import Foundation

enum CarServiceError: Error {
    case invalidURL
    case invalidData
    case decodingError
}

protocol CarServiceProtocol {
    func fetchCars(completion: @escaping (Result<[Car], Error>) -> Void)
}

struct CarService: CarServiceProtocol {
    func fetchCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        guard let url = URL(string: "https://5fc9346b2af77700165ae514.mockapi.io/products") else {
            completion(.failure(CarServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(CarServiceError.invalidData))
                return
            }
            
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                completion(.success(cars))
            } catch {
                completion(.failure(CarServiceError.decodingError))
            }
        }.resume()
    }
}
