//
//  View+Extension.swift
//  eterationcase
//
//  Created by Tayfun Sagdic on 24.02.2024.
//

import SwiftUI

extension View {
  func navigationBarBackground(_ background: Color = .accentColor) -> some View {
    return self
      .modifier(ColoredNavigationBar(background: background))
  }
}

extension View {
    func navigationBackButton(color: UIColor, text: String? = nil) -> some View {
        modifier(NavigationBackButton(color: color, text: text))
    }
}


