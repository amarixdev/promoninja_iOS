
import SwiftUI


struct QuestionsView: View {
    @State private var rotateAngle = 370
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    @ViewBuilder
    func questionBlock(question: String, answer: String) -> some View {
        VStack(alignment:.leading, spacing: 10) {
            Text(question)
                .font(.headline)
            Text(answer)
                .opacity(0.8)
                .font(.subheadline)
        }
    
    }
    
    var body: some View {
        ZStack {
            GradientView()
            ScrollView {
                VStack {
                    Image(.logo)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .rotation3DEffect(
                            .degrees(Double(rotateAngle)),
                                                  axis: (x: 0.0, y: 0.0, z: 1.0)
                            
                    
                        )
                        .shadow(color:.black, radius: 4, x: 2, y: 3)
                        .padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Did you know?")
                            .font(.title)
                            .fontWeight(.semibold)
                            .opacity(0.8)
                        Text("Podcasts typically earn 5% - 20% commission when listeners use their affiliate links.")
                            .font(.subheadline)
                            .opacity(0.8)
                        
                        HStack {
                            Text("Commonly Asked")
                                .font(.title)
                                .fontWeight(.semibold)
                                .opacity(0.8)
                            Spacer()
                        }
                        .padding(.top, 20)
                        VStack(alignment:.leading, spacing: 50) {
                                questionBlock(question: "What exactly is Promoninja?", answer: "PromoNinja is a free platform that brings together podcast creators, listeners, and sponsors. It simplifies sponsorship management for creators, provides exclusive promotions for listeners, and offers increased reach for sponsors. It's an all in one application for anyone who enjoys podcasts and saving money.")
                            
                                
                            questionBlock(question: "What if I don't see a podcast I want to support?", answer: "No worries! You can still enjoy the various discounts offered across a wide range of podcasts.")
                            
                            questionBlock(question: "How do I know the offers are up to date?", answer: "Offers are updated weekly. If you encounter an expired offer, feel free to report it.")
                            
                            questionBlock(question: "What if, for example, Audible offers 30% off for one podcast, and 60% for another? ", answer: "We focus on showcasing deals that are consistent across all podcasts. Fortunately, the majority of affiliate deals we showcase adhere to this standard.")
                            
                            questionBlock(question: "How can I get my podcast featured on the platform?", answer: "Podcasts must have at least one sponsor to be featured. If you would like to have your show featured, contact us @Promoninja1.gmail.com")
                        }
                    
                       
                        
                    }
                }
                .padding(20)
                .padding(.bottom, 20)
            }
          
          
        }
        .navigationTitle("Questions")
        .toolbarBackground(.visible, for: .tabBar)
        .tint(.black)

        .toolbarStyle(inline: true)
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                if rotateAngle == 350 {
                    rotateAngle = 370
                } else {rotateAngle = 350}
            }
          
        })
      
        
        
     
    }
}


#Preview {
    NavigationStack {
        QuestionsView()
            .preferredColorScheme(.dark)
    }
   
}
