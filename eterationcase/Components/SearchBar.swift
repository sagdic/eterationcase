//
//  SearchBar.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 25.02.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $text)
                }
                .padding(20)
                .overlay(
                  RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 1)
                    .padding()
                )
        }
}
