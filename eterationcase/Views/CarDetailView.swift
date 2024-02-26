//
//  CarDetailView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 24.02.2024.
//

import SwiftUI

struct CarDetailView: View {
    let car: Car
    @StateObject private var imageLoader = ImageLoader()
    @StateObject var viewModel = CarViewModel()
    let titleText: String
    
    var body: some View {
        GeometryReader { geometry in
                VStack(spacing: 16) {
                    ZStack(alignment: .topTrailing) {
                        if let uiImage = imageLoader.image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: (geometry.size.width - 32), height: (geometry.size.height * 0.50 - 32))
                        } else {
                            ProgressView()
                        }
                        
                        Button(action:{
                            if viewModel.favoriteCars.contains(where: { $0.id == car.id }) {
                                viewModel.removeFavorite(car: car)
                            } else {
                                viewModel.addFavorite(car: car)
                            }}) {
                                ZStack{
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.gray)
                                    Image(systemName: viewModel.favoriteCars.contains(where: { $0.id == car.id }) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                                
                            }
                            .padding(.trailing, 8)
                            .padding(.top, 8)
                    }
                    
                    
                    
                    HStack{
                        Text((car.name ?? "") + " "  + (car.model ?? ""))
                            .font(.title).padding(.top,20)
                    }
                    
                    Text(car.description ?? "")
                        .lineLimit(7)
                    
                    Spacer()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Price:")
                                .foregroundStyle(.accent)
                            Text("\(car.price ?? "")₺")
                                .foregroundStyle(.black)
                                .bold()
                        }
                        Spacer()
                        Button(action: {
                            viewModel.addToCart(name: car.name ?? "unknown", price: car.price ?? "0", quantity: 1)
                        }) {
                            Text("Add To Cart")
                        }
                        .frame(width: geometry.size.width * 0.5, height: 50)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(5)
                    }
                    
                }
            }.onAppear{
                if let image = car.image {
                    imageLoader.loadImage(from: image)
                }
            }
            .padding()
            .background(Color.white)
            .navigationBarBackground()
            .navigationBackButton(color: .white)
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text(titleText)
                                    .font(.headline)
                                    .foregroundColor(.white)
                        }
                    }
        }
}
