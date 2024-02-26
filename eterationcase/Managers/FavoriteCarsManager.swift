//
//  FavoriteCarsManager.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 26.02.2024.
//

import Foundation

class FavoriteCarsManager {
    static let shared = FavoriteCarsManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoriteCarsKey = "FavoriteCars"
    
    func getFavoriteCars() -> [Car] {
        guard let data = userDefaults.data(forKey: favoriteCarsKey) else { return [] }
        do {
            let cars = try JSONDecoder().decode([Car].self, from: data)
            return cars
        } catch {
            print("Error decoding favorite cars: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveFavoriteCars(_ cars: [Car]) {
        do {
            let data = try JSONEncoder().encode(cars)
            userDefaults.set(data, forKey: favoriteCarsKey)
        } catch {
            print("Error encoding favorite cars: \(error.localizedDescription)")
        }
    }
}
