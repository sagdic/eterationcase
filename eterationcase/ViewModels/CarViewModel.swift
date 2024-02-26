//
//  CarViewModel.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    private let carService: CarServiceProtocol
    private let cartRepository: CartRepository
    
    init(carService: CarServiceProtocol = CarService(), cartRepository: CartRepository = CartRepository.shared) {
        self.carService = carService
        self.cartRepository = cartRepository
        fetchCars()
    }
    
    func fetchCars() {
        carService.fetchCars { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cars):
                    self.cars = cars
                case .failure(let error):
                    print("Error fetching cars: \(error)")
                }
            }
        }
    }
    
    func addToCart(car: Car) {
        cartRepository.addToCart(car: car)
    }
}
