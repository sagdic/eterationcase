//
//  HomeView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = CarViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(viewModel.cars) { car in
                    CarCard(car: car) {
                        viewModel.addToCart(car: car)
                    }
                }
            }
        }
        .navigationTitle("Home")
    }
}
