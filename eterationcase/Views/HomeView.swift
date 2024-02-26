//
//  HomeView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = CarViewModel()
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack {
                    HStack{
                        SearchBar(text: $viewModel.searchText)
                        Picker("Filter by", selection: $viewModel.filterOption) {
                            Text("Name").tag(FilterOption.name)
                            Text("Model").tag(FilterOption.model)
                        }
                        .pickerStyle(DefaultPickerStyle())
                    }.padding(.horizontal,8)
                                        Group {
                                            if viewModel.isLoading {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle())
                                                    .scaleEffect(2)
                                                    .padding()
                                                    .foregroundStyle(Color.accentColor)
                                                    .cornerRadius(10)
                                                    .shadow(radius: 10)
                                            } else {
                                                ScrollView {
                                                    LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                                                        ForEach(viewModel.isSearching ? viewModel.filteredCars : viewModel.cars) { car in
                                                            NavigationLink(destination: CarDetailView(car: car, viewModel: viewModel,titleText: car.name ?? "Unknown Car")) {
                                                                CarCard(car: car, addToCartAction: {
                                                                    viewModel.addToCart(name: car.name ?? "Unknown Car", price: car.price ?? "0", quantity: 1)
                                                                }, favAction: {
                                                                    if viewModel.favoriteCars.contains(where: { $0.id == car.id }) {
                                                                        viewModel.removeFavorite(car: car)
                                                                    } else {
                                                                        viewModel.addFavorite(car: car)
                                                                    }
                                                                }, isStarFilled: viewModel.favoriteCars.contains(where: { $0.id == car.id }) ? true : false)
                                                                .frame(width: (geometry.size.width - 48) / 2, height: (geometry.size.height - 48) / 2)
                                                            }
                                                        }
                                                    }
                                                    .padding(16)
                                                }
                                            }
                                        }
                    
                    
                }
                .onChange(of: viewModel.searchText) { newValue in
                    viewModel.filterCars(searchText: newValue)
                }
                .onChange(of: viewModel.filterOption) {newValue in
                    viewModel.searchText = ""
                }
                .navigationBarBackground()
                .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("E-Market")
                                        .font(.headline)
                                        .foregroundColor(.white)
                            }
                        }
            }
        }.ignoresSafeArea()
    }
}


