//
//  ContentView.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 23.02.2024.
//

import SwiftUI
import CoreData

struct MainView: View {

    var body: some View {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Anasayfa", systemImage: "house")
                        }
                    CartView()
                        .tabItem {
                            Label("Sepet", systemImage: "cart")
                        }
                    FavoritesView()
                        .tabItem {
                            Label("Favoriler", systemImage: "heart")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profil", systemImage: "person")
                        }
                }
                .onAppear {
                    //productViewModel.fetchProducts()
                }
            }
}

