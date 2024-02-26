//
//  CarRepository.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 24.02.2024.
//



class CartRepository {
    static let shared = CartRepository()
    
    private var cartItems: [Car: Int] = [:]
    
    func addToCart(car: Car) {
        if let existingQuantity = cartItems[car] {
            cartItems[car] = existingQuantity + 1
        } else {
            cartItems[car] = 1
        }
        print("Added \(car.name ?? "Unknown Car") to cart")
    }
    
    func removeFromCart(car: Car) {
        if let existingQuantity = cartItems[car], existingQuantity > 1 {
            cartItems[car] = existingQuantity - 1
        } else {
            cartItems.removeValue(forKey: car)
        }
        print("Removed \(car.name ?? "Unknown Car") from cart")
    }
    
    func getCartItems() -> [(car: Car, quantity: Int)] {
        return cartItems.map { ($0.key, $0.value) }
    }
    
    func getTotalPrice() -> String {
        let totalPrice = cartItems.reduce(0.0) { (result, item) in
            let car = item.key
            let quantity = Double(item.value)
            let price = Double(car.price ?? "0") ?? 0.0
            return result + (price * quantity)
        }
        return String(format: "%.2f", totalPrice)
    }
}
