//
//  FavoritesView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: CarViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.favoriteCars.isEmpty {
                VStack{
                    Spacer()
                    Text("Hiç favoriniz yok")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title)
                    Spacer()
                }
            } else {
                List(viewModel.favoriteCars) { car in
                    NavigationLink(destination: CarDetailView(car: car, viewModel: viewModel, titleText: car.name ?? "Unknown Car")) {
                        VStack(alignment: .leading) {
                            Text(car.name ?? "Unknown Car")
                                .font(.headline)
                            Text(car.model ?? "Unknown Model")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }.navigationTitle("Favorites")
        
    }
}
