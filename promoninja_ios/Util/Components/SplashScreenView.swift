
import SwiftUI

struct MainContent: View {
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Hello world")
                .foregroundStyle(.white)
        }
        
        
    }
}

struct SplashScreenView: View {
    @State private var scale:CGSize = CGSize(width: 0.8, height: 0.8)
    @State private var textscale:CGSize = CGSize(width: 1.0, height: 1.0)

    @State private var mainImageOpacity: Double = 1.0
    @State private var effectImageOpacity: Double = 0.0
    @State private var opacity: Double = 1.0
    
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing:0) {
                ZStack {
                    Image(.logo)
                        .resizable()
                        .foregroundStyle(.white)
                        .opacity(mainImageOpacity)
                        .frame(width: 150, height: 150)
                    
                    Image(.glitchedLogo)
                        .resizable()
                        .foregroundStyle(.white)
                        .opacity(effectImageOpacity)
                        .frame(width: 150, height: 150)
                }
                .scaleEffect(scale)
                Image(.logoText)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 50)
                    .scaleEffect(textscale)
                    .offset(y: -15)

            }
           
        }
        .preferredColorScheme(.dark)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }
            
            for i in 0..<7 {
                withAnimation {
                    setTimeout(1.5 + Double(i) * 0.1) {
                        if effectImageOpacity == 0.0 {
                            effectImageOpacity = 1
                        } else {
                            effectImageOpacity = 0
                        }
                    }
                }
        
            }
            
            setTimeout(2.5) {
                withAnimation(.easeOut(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    textscale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            }
            setTimeout(2.9) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPresented = false
                }
                
            }
        }
        
        
    }
}


struct ContainerView: View {
    @State private var isSplashScreenViewPresented = true
    var body: some View {
        if !isSplashScreenViewPresented {
            MainContent()
        } else {
            SplashScreenView(isPresented: $isSplashScreenViewPresented)
        }
    }
}



#Preview {
    ContainerView()
        .preferredColorScheme(.dark)
}
