//
//  QuestionsView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/24/23.
//

import SwiftUI

struct QuestionsView: View {
    @State private var rotateAngle = 370
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func questionBlock (question: String, answer: String) -> some View {
        DisclosureGroup(
            content: { Text(answer)
                    .font(.subheadline)
                    .opacity(0.8)
                    .padding(.vertical)
            },
            label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(height: 80)
                        .cornerRadius(10)
                    Text(question)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding()
                }
            }
        )
        .padding(.horizontal)
        
     
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.5), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
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
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Did you know?")
                            .font(.title)
                            .fontWeight(.semibold)
                            .opacity(0.8)
                        Text("Podcasts typically earn 5% - 20% commission when listeners use their affiliate links")
                            .font(.subheadline)
                        
                        HStack {
                            Text("Commonly Asked")
                                .font(.title)
                                .fontWeight(.semibold)
                                .opacity(0.8)
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                    
             
                    VStack {
                        questionBlock(question: "What is Promoninja?", answer: "PromoNinja is a free platform that brings together podcast creators, listeners, and sponsors. It simplifies sponsorship management for creators, provides exclusive promotions for listeners, and offers increased reach for sponsors. It's an all in one application for anyone who enjoys podcasts and saving money.")
                        questionBlock(question: "What if I don't see a podcast I want to support?", answer: "No worries! You can still enjoy the various discounts offered across a wide range of podcasts.")
                        
                        questionBlock(question: "How do I know the offers are up to date?", answer: "Offers are updated weekly. If you encounter an expired offer, feel free to report it")
                    }
                    .padding(.bottom)
                   
                    
                 
                   
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Questions")
        .toolbarStyle()
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
    }
    .preferredColorScheme(.dark)
    
        
}
