//
//  eterationcaseTests.swift
//  eterationcaseTests
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import XCTest
@testable import eterationcase

final class eterationcaseTests: XCTestCase {
    var viewModel: CarViewModel!
    
    override func setUpWithError() throws {
        viewModel = CarViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testAddToCart() throws {
        // Given
        let initialCartItemCount = viewModel.cartItems.count
        let carName = "Test Car"
        let carPrice = "100"
        let quantity: Int16 = 1
        
        // When
        viewModel.addToCart(name: carName, price: carPrice, quantity: quantity)
        
        // Then
        XCTAssertEqual(viewModel.cartItems.count, initialCartItemCount + 1)
    }
    
    func testRemoveFromCart() throws {
        // Given
        let carName = "Test Car"
        let carPrice = "100"
        let quantity: Int16 = 1
        viewModel.addToCart(name: carName, price: carPrice, quantity: quantity)
        
        // When
        let initialCartItemCount = viewModel.cartItems.count
        viewModel.removeFromCart(cartItem: viewModel.cartItems.first!)
        
        // Then
        XCTAssertEqual(viewModel.cartItems.count, initialCartItemCount - 1)
    }
}
