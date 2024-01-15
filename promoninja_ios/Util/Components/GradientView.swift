//
//  GradientView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/6/24.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        ZStack {
            Color.black
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.75), .sponsorTheme.opacity(0.5), .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
      
        }
        .ignoresSafeArea()
  
    }
}

#Preview {
    GradientView()
        .preferredColorScheme(.dark)
}
