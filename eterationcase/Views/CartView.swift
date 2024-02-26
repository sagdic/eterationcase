//
//  CartView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel = CarViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.cars) { item in
                    HStack {
                        Text(item.name ?? "Unknown Car")
                        Spacer()
                        Text("\(item.car.price ?? "0")₺")
                        Spacer()
                        HStack {
                            Button("-") {
                                
                            }
                            Text("quantity")
                            Button("+") {
                                
                            }
                        }
                    }
                }
            }
            Text("Total Price: \(viewModel.cartRepository.getTotalPrice())₺")
        }
    }
}
