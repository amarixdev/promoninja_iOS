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
                Rectangle().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(.circular)
            }
            .onChange(of: podcast) {
                dataLoaded = true
            }
          
        } else {
          
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [podcastTheme, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        
                   ScrollView {
                       
                        VStack {
                        
                                AsyncImage(
                                    url: URL(string: podcast?.imageUrl ?? "")
                                ) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(width: 180, height: 180)
                                             .cornerRadius(20)
                                             .shadow(radius: 10)
                                    } else {
                                        ZStack {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                            Rectangle()
                                                .foregroundStyle(.white.opacity(0.2))
                                                
                                                
                                        }
                                        .frame(width: 180, height: 180)
                                        .cornerRadius(20)
                                      
                                            
                                            
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
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarTitleDisplayMode(.inline)
                .tint(.white)
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
    PodcastView( title: "Aubrey Marcus Podcast")
        .preferredColorScheme(.dark)
}
