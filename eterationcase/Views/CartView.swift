//
//  CartView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CarViewModel
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                if viewModel.cartItems.isEmpty {
                    VStack{
                        Spacer()
                        Text("Sepetiniz boş")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.title)
                        Spacer()
                    }
                } else {
                        VStack {
                            ScrollView{
                            ForEach($viewModel.cartItems, id: \.id) { $item in
                                HStack {
                                    VStack(alignment: .leading){
                                        Text(item.name ?? "Unknown Car")
                                            .frame(width: geometry.size.width * 0.4, alignment: .leading)
                                            .lineLimit(1)
                                        Text("\(item.price ?? "0")₺")
                                            .foregroundStyle(.accent)
                                    }.padding(.leading,20)
                                    
                                    Spacer()
                                    HStack(spacing: 0) {
                                        Button(action: {
                                            viewModel.removeFromCart(cartItem: item)
                                        }) {
                                            Text("-")
                                        }
                                        .background(Color("AppLightGray").frame(width: 50, height: 50))
                                        .frame(width: 50, height: 50)
                                        
                                        Rectangle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.accent)
                                            .overlay(
                                                Text("\(item.quantity)")
                                                    .foregroundColor(.white)
                                            )
                                        
                                        Button(action: {
                                            viewModel.addToCart(name: item.name ?? "unknown", price: item.price ?? "0", quantity: item.quantity)
                                        }) {
                                            Text("+")
                                        }
                                        .background(Color("AppLightGray").frame(width: 50, height: 50))
                                        .frame(width: 50, height: 50)
                                    }
                                }
                                }
                            }
                            Spacer()
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Total:")
                                        .foregroundStyle(.accent)
                                    Text(String(format: "%.2f ₺", viewModel.totalPrice))
                                        .foregroundStyle(.black)
                                        .bold()
                                }
                                Spacer()
                                Button(action: {
                                    print("Complete")
                                }) {
                                    Text("Complete")
                                }
                                .frame(width: geometry.size.width * 0.4, height: 50)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(5)
                            }
                        }
                    .padding(16)
                    .navigationBarBackground()
                    .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("E-Market")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                }
                            }

                }
            }
        }
    }
}
