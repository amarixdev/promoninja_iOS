import SwiftUI


struct TextCustom<T:View>: View {
    let content: T
    
    init(@ViewBuilder content: ()-> T) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}



struct Playground: View {
    var body: some View {
        
        ZStack {
          
            TextCustom {
                Text("tester")
            }
            Rectangle()
                  .frame(width: 100, height: 100)
                  .foregroundStyle(.red.opacity(0.5))
                  .blur(radius: 3)
        }
    
            
    }
}



#Preview {
    Playground()
}
