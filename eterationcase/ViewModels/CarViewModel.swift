//
//  CarViewModel.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI
import CoreData

enum FilterOption {
    case name
    case model
}

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var filteredCars: [Car] = []
    @Published var cartItems: [CartItem] = []
    @Published var favoriteCars: [Car] = FavoriteCarsManager.shared.getFavoriteCars()
    @Published var totalPrice: Double = 0.0
    @Published var totalCartItems: Int16 = 0
    @Published var searchText: String = ""
    @Published var filterOption: FilterOption = .name
    @Published var isLoading: Bool = false

    
    private let carService: CarServiceProtocol
    
    init(carService: CarServiceProtocol = CarService()) {
        self.carService = carService
        fetchCars()
        fetchCartItems()
    }
    
    func fetchCars() {
        isLoading = true
        carService.fetchCars { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let cars):
                    self.cars = cars
                case .failure(let error):
                    print("Error fetching cars: \(error)")
                }
            }
        }
    }
    
    func fetchCartItems() {
        isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        do {
            cartItems = try context.fetch(fetchRequest)
            updateTotalCart()
            isLoading = false
        } catch {
            print("Error fetching cart items: \(error)")
        }
    }
    
    var isSearching: Bool {
            !searchText.isEmpty
        }
    
    func filterCars(searchText: String) {
        guard !searchText.isEmpty else {
                    filteredCars = []
                    return
                }
        
        filteredCars = cars.filter { car in
            switch filterOption {
            case .name:
                return car.name?.lowercased().contains(searchText.lowercased()) ?? false
            case .model:
                return car.model?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }

    
    func addToCart(name: String, price: String, quantity: Int16) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let existingCartItem = try context.fetch(fetchRequest).first
            
            if let existingCartItem = existingCartItem {
                existingCartItem.quantity += quantity
            } else {
                let cartItem = CartItem(context: context)
                cartItem.id = UUID()
                cartItem.name = name
                cartItem.price = price
                cartItem.quantity = quantity
            }
            
            CoreDataManager.shared.saveContext()
            fetchCartItems()
        } catch {
            print("Error fetching cart items: \(error)")
        }
    }

    
    func removeFromCart(cartItem: CartItem) {
            let context = CoreDataManager.shared.context
        if cartItem.quantity < 2 {
            context.delete(cartItem)
        } else {
            cartItem.quantity -= 1
        }
            
            CoreDataManager.shared.saveContext()
            fetchCartItems()
        }
    
    private func updateTotalCart() {
        totalPrice = cartItems.reduce(0.0) { (result, item) in
            let price = Double(item.price ?? "0") ?? 0.0
            return result + (price * Double(item.quantity))
        }
        self.totalCartItems = cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    func addFavorite(car: Car) {
           favoriteCars.append(car)
           FavoriteCarsManager.shared.saveFavoriteCars(favoriteCars)
       }
       
       func removeFavorite(car: Car) {
           if let index = favoriteCars.firstIndex(where: { $0.id == car.id }) {
               favoriteCars.remove(at: index)
               FavoriteCarsManager.shared.saveFavoriteCars(favoriteCars)
           }
       }
}
