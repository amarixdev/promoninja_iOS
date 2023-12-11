//
//  LoadingAnimation.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/4/23.
//

import SwiftUI


struct LoadingAnimation: View {
    var homeScreen: Bool?
    @State private var rotation: Double = 0.0
    @State private var displayLoader = false
    
    var isHomeScreen: Bool {
        homeScreen != nil
    }
    
    var body: some View {
        VStack {
            CircleView(offset: 0, isHomeScreen: isHomeScreen)
                .rotationEffect(Angle(degrees: rotation))
            CircleView(offset: 120, isHomeScreen: isHomeScreen)
                .rotationEffect(Angle(degrees: rotation + 120))
            CircleView(offset: 240, isHomeScreen: isHomeScreen)
                .rotationEffect(Angle(degrees: rotation + 240))
        }
        .transition(.opacity)
        .opacity(!isHomeScreen && !displayLoader ? 0 : !isHomeScreen && displayLoader ? 1 : 1)
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                rotation = 360
            }
            if !isHomeScreen {
                setTimeout(1.0) {
                        withAnimation(.easeIn) {
                            displayLoader = true
                        }
                      
                    }
            }
     
            
        }
    }
}

struct CircleView: View {
    let offset: Double
    let isHomeScreen: Bool
    
    var body: some View {
        Circle()
            .fill(isHomeScreen ? .loading : .loading)
            .frame(width: 20, height: 20)
            .offset(x: 80 * cos(offset * .pi / 180), y: 80 * sin(offset * .pi / 180))
    }
}


#Preview {
    LoadingAnimation()
        .preferredColorScheme(.dark)
}
