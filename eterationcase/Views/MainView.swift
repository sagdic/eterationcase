//
//  ContentView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var carViewModel = CarViewModel()
    
    var body: some View {
        TabView {
            HomeView(viewModel: carViewModel)
                .tabItem {
                    Label("Anasayfa", systemImage: "house")
                }
            CartView(viewModel: carViewModel)
                .tabItem {
                    Label("Sepet", systemImage: "cart")
                        
                }.badge(carViewModel.totalCartItems > 0 ? "\(carViewModel.totalCartItems)" : nil )
            FavoritesView(viewModel: carViewModel)
                .tabItem {
                    Label("Favoriler", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
        }
    }
}
