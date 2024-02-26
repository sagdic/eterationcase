//
//  CarCard.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct CarCard: View {
    let car: Car
    let action: () -> Void
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(10)
            } else {
                ProgressView()
            }
            Text("\(car.price ?? "")₺")
                .font(.headline)
                .padding(.vertical, 4)
            
            Text(car.name ?? "")
                .font(.subheadline)
                .padding(.vertical, 4)
            
            Text(car.model ?? "")
                .font(.subheadline)
                .padding(.vertical, 4)
            
            Spacer()
            
            Button(action: action) {
                Text("Add to Cart")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }.onAppear{
            if let image = car.image {
                imageLoader.loadImage(from: image)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
