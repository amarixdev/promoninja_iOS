//
//  ShineEffect.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/13/23.
//

import SwiftUI

struct ShineEffect: View {
    @State private var shine: Bool = false
    var body: some View {
       Rectangle()
            .frame(width: 100, height: 100)
            .foregroundStyle(.cyan)
            .shine(shine)
            .onTapGesture {
                shine.toggle()
            }
            
    }
}

extension View {
    @ViewBuilder
    func shine(_ toggle: Bool) -> some View {
        
        let duration = 0.8
        let clipShape: some Shape = .rect(cornerRadius: 10)
        
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    
                    //eliminating negative duration
                    
                    let moddedDuration = max(0.3, duration)
                    
                    Rectangle()
                        .fill(.linearGradient (
                            colors: [
                                .clear,
                                .clear,
                                .white.opacity(0.1),
                                .white.opacity(0.5),
                                .white.opacity(1),
                                .white.opacity(0.5),
                                .white.opacity(0.1),
                                .clear,
                                .clear
                             
                                    
                                
                            ], startPoint: .leading, endPoint: .trailing))
                        .scaleEffect(y:8)
                       
                        .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: { content, progress in
                            content
                                .offset(x: -size.width + (progress * (size.width * 2)))
                        }, keyframes: { _ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: moddedDuration)
                        })
                        .rotationEffect(.degrees(45))
                }
            }
            .clipShape(clipShape)
         
        
            
            

    }
}


#Preview {
    ShineEffect()
}
