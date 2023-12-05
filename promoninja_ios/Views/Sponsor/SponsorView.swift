//
//  SponsorView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import PromoninjaSchema



struct SponsorView: View {
    @StateObject var viewModel: SponsorViewModel
    @Environment(\.dismiss) var dismiss

    var name: String
    
    init(name: String ) {
        self.name = name
        self._viewModel = StateObject(wrappedValue: SponsorViewModel(name: name, homePage: false))
    }
    
    var sponsor: GetSponsorQuery.Data.GetSponsor? {
        viewModel.sponsorData
    }
    
     @State var listTapped = false
     @State var dataLoaded = false

        var body: some View {
            if !dataLoaded {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    LoadingAnimation()
                        
                }
                .onChange(of: sponsor) {
                    dataLoaded = true
                }
                .toolbarStyle()
                
                   
            } else {
           
                    ZStack {
                        
                        LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            
                       ScrollView {
                            VStack {
                       
                                    AsyncImage(
                                        url: URL(string: sponsor?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)
                                    ) { phase in
                                        
                                        if let image = phase.image {
                                            image.resizable()
                                                .scaledToFill()
                                                 .frame(width: 180, height: 180)
                                                 .cornerRadius(10)
                                        } else {
                                            Placeholder(frameSize: 180, imgSize: 55, icon: .sponsor)
                                        }
                                          
                                    }
                                
                                if let url = sponsor?.url {
                                    Text(url.truncated(35))
                                        .font(.subheadline)
                                        .padding(.vertical)
                                }
                                
                                if let summary = sponsor?.summary {
                            
                                    Text(summary)
                                        .multilineTextAlignment(.center)
                                        .font(.subheadline)
                                        .opacity(0.8)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 20)
                                }
                                
                                //exclusive offer
                                ZStack {
                                    Rectangle()
                                        .frame(width: .none, height: 120)
                                        .foregroundStyle(.ultraThinMaterial)
                                        .shadow(color: .black, radius: 20)
                                    
                                    VStack(spacing: 12) {
                                        if let offer = sponsor?.offer {
                                            HStack {
                                                Circle()
                                                    .frame(width: 5, height: 5)
                                                    .foregroundStyle(.green)
                                                Text("Exclusive Offer:")
                                                    .fontWeight(.bold)
                                            }
                                            
                                            Text(offer)
                                                .font(.subheadline)
                                                .multilineTextAlignment(.center)
                                                .opacity(0.8)
                                        }
                                        
                                    }
                                    .padding(.vertical, 20)
                                    .frame(width: 300)
                                    
                                  
                                }
                                .padding(.vertical, 40)
                                
                                //call-to-action
                                
                                VStack {
                                    Image(.logo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                    Text("""
                                               "Empower your favorite podcaster by making your purchase through their affiliate link."
                                               
                                               """)
                                        .multilineTextAlignment(.center)
                                       
                                        .italic()
                                        .font(.subheadline)
                                        .opacity(0.8)
                                }
                                .frame(width: 300)
                                
                                
                            }
                          
                              
                                .padding(.bottom, 15)
                           
          
                               //Buttons
                    
                           
                                .padding(.top)
                        
                                //Podcasts
                           
                               
                              PodcastListView(sponsor: sponsor)
                                                        
                                Spacer()
                            }
                                .padding(.vertical)
                                .padding(.horizontal, 0)
                        }
                   
                    .navigationTitle(sponsor?.name?.truncated(25) ?? "")
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .tint(.white)
                        .toolbarTitleDisplayMode(.inline)
                
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                
                
                

                        
                    }
                   
                
                
                
            }
     
        }

#Preview {
    SponsorView(name: "squarespace")
        .preferredColorScheme(.dark)
}
