//
//  ImageLoader.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

//import SwiftUI
//import Combine
//
//class ImageLoader: ObservableObject {
//    @Published var image: UIImage?
//    private var cancellable: AnyCancellable?
//    
//    func loadImage(from url: String) {
//        guard let url = URL(string: url) else { return }
//        
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] image in
//                self?.image = image
//            }
//    }
//}
