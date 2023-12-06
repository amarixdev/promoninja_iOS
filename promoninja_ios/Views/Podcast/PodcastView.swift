//
//  Podcast.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import PromoninjaSchema


struct PodcastView: View {
    @StateObject var viewModel: PodcastViewModel
    @Environment(\.dismiss) var dismiss
    var title: GraphQLNullable<String>
    
    init(title: GraphQLNullable<String>) {
        self.title = title
        self._viewModel = StateObject(wrappedValue: PodcastViewModel(title: title))
        
    }

    var podcast: GetPodcastQuery.Data.GetPodcast? {
            viewModel.podcastData
    }
    
    
    
    var podcastTheme: Color {
        return Color(rgbString: podcast?.backgroundColor ?? "rgb(0,0,0)")
    }
    
    
   @State var dataLoaded = false
    @State var showMore = false
    
    var body: some View {
        if  podcast?.sponsors?.count == nil {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                PulsatingLoadingView()
            }
            .onChange(of: podcast) {
                dataLoaded = true
            }
            .toolbarStyle()
          
        } else {
          
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [podcastTheme, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        
                   ScrollView {
                       
                        VStack {
                        
                                AsyncImage(
                                    url: URL(string: podcast?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)
                                ) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(width: 180, height: 180)
                                             .cornerRadius(10)
                                             .shadow(radius: 10)
                                    } else {
                                        Placeholder(frameSize: 180, imgSize: 55, icon: .podcast)
                                      
                                            
                                            
                                    }
                                  
                                      
                                }
                                .padding(.bottom, 15)
              
                            if let publisher = podcast?.publisher {
                                Text(publisher.truncated(35))
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    
                            }
              
                            
                            if let description = podcast?.description {
                                VStack(spacing: 15) {
                                    DisclosureGroup(isExpanded: $showMore) {
                                        Text(description)
                                    } label: {
                                        Button {
                                            withAnimation {
                                                showMore.toggle()
                                            }
                                           
                                        } label: {
                                            Text(showMore ? "Hide details" : "See details")
                                                
                                               
                                               
                                            
                                        }
                                        .buttonStyle(.bordered)
                                        .padding(.bottom)
                                        .animation(.none, value: showMore)
                                    }

                                  
                               
                                        .font(.subheadline)
                      

                                }
                                
                                .transition(.move(edge: .bottom))
                                .padding(20)
                                .opacity(0.8)
                          
                              
                            }
                            
                                
                               
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: .none, height: 90)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .shadow(color: .black, radius: 20)
                                
                                VStack(spacing: 12) {
                                    Text("Thanks for supporting the show.")
                                        .font(.subheadline)
                                        .opacity(0.8)
                                   
                                }
                           
                            }
                            .padding(.vertical, 40)

                            
                            
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
                            
                            //Buttons
                   
                           
                            //Sponsors
                            HStack {
                              
                                
                            }
                            .padding(.leading)
                               
                                SponsorListView(podcast: podcast)
                          
                        
                            Spacer()
                        }
                    }
              
                   .padding(.vertical)
                   .padding(.horizontal, 0)
                   
                   
                   
                    
                    
                }
                .navigationTitle(podcast?.title.truncated(25) ?? "")
                .toolbarStyle()
        
           
             
        }
        
        
    
 
    }
}

#Preview {
    PodcastView( title: "Aubrey Marcus Podcast")
        .preferredColorScheme(.dark)
}
