//
//  LoadingAnimation.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/4/23.
//

import SwiftUI


struct LoadingAnimation: View {
    @State private var rotation: Double = 0.0
    
    var body: some View {
        VStack {
            CircleView(offset: 0)
                .rotationEffect(Angle(degrees: rotation))
            CircleView(offset: 120)
                .rotationEffect(Angle(degrees: rotation + 120))
            CircleView(offset: 240)
                .rotationEffect(Angle(degrees: rotation + 240))
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct CircleView: View {
    let offset: Double
    
    var body: some View {
        Circle()
            .fill(.loading)
            .frame(width: 20, height: 20)
            .offset(x: 80 * cos(offset * .pi / 180), y: 80 * sin(offset * .pi / 180))
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}

#Preview {
    LoadingAnimation()
}
