//
//  ColoredNavigationBar.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 26.02.2024.
//

import SwiftUI

struct ColoredNavigationBar: ViewModifier {
  var background: Color
  
  func body(content: Content) -> some View {
    content
      .toolbarBackground(
        background,
        for: .navigationBar
      )
          .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.visible, for: .navigationBar)
  }
}
