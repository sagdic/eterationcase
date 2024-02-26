//
//  CarCard.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct CarCard: View {
    let car: Car
    let addToCartAction: () -> Void
    let favAction: () -> Void
    var isStarFilled: Bool = false
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                                if let uiImage = imageLoader.image {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: (geometry.size.width - 32), height: (geometry.size.height * 0.50 - 32))
                                } else {
                                    ProgressView()
                                }
                                
                                Button(action: favAction) {
                                    ZStack{
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.gray)
                                        Image(systemName: isStarFilled ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding(.trailing, 8)
                                .padding(.top, 8)
                            }
                Text("\(car.price ?? "")₺")
                    .font(.headline)
                    .padding(.vertical, 4).foregroundStyle(.accent)
                Spacer()
                Text(car.name ?? "")
                    .foregroundStyle(.black)
                Text(car.model ?? "")
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button(action: addToCartAction) {
                    Text("Add to Cart")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(5)
                }
            }.onAppear{
                if let image = car.image {
                    imageLoader.loadImage(from: image)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
