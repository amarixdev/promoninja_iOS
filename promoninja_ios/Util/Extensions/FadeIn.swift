//
//  FadeIn.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/10/23.
//

import SwiftUI



struct FadeIn: ViewModifier {
    @Binding var viewLoaded: Bool
    
    func body (content: Content ) -> some View {
        content
            .onAppear {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewLoaded = true
                }
            }
            .opacity(viewLoaded ? 1 : 0)
    }
}

extension View {
    
    
    func fadeInView (viewLoaded: Binding<Bool>) -> some View {
       modifier(FadeIn(viewLoaded: viewLoaded))
    }
}


