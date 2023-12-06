//
//  LoadingAnimation2.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/6/23.
//

import SwiftUI

struct PulsatingLoadingView: View {
    @State private var pulsate = false
    
    //   LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
   
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity( pulsate ? 0.25 : 0.75), .black]), startPoint: .top, endPoint: .bottom)
                .animation(Animation.easeInOut(duration: 1.0)
                    .repeatForever(autoreverses: true), value: pulsate)
            
                .onAppear() {
                    self.pulsate.toggle()
                }
            
  
        }
        .edgesIgnoringSafeArea(.all)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PulsatingLoadingView()
            .preferredColorScheme(.dark)
    }
}
