//
//  LoadingAnimation.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/4/23.
//

import SwiftUI

struct LoadingDots: View {
    @State private var isLoading = false

    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.logo.gradient)
                    .scaleEffect(self.isLoading ? 1 : 0.6)
                    .animation(
                        Animation
                            .default
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) / 6),
                        value: isLoading
                    )
            }
        }
        .onAppear() {
            withAnimation {
                self.isLoading = true
            }
          
        }
    }
}


struct LoadingAnimation: View {
    var homeScreen: Bool
    @State private var rotation: Double = 0.0
    @State private var displayLoader = false
    
 
    
    var body: some View {
        VStack(alignment:.center) {
            LoadingDots()
        }
        .transition(.opacity)
        .opacity(!homeScreen && !displayLoader ? 0 : !homeScreen && displayLoader ? 1 : 1)
        .onAppear {
            if !homeScreen {
                setTimeout(1.0) {
                    print("")
                        withAnimation(.easeIn) {
                            displayLoader = true
                        }
                      
                    }
            }
     
        }
        .environment(\.colorScheme, .dark)
    }
}


#Preview {
    LoadingAnimation(homeScreen: false)
        .preferredColorScheme(.dark)
}
