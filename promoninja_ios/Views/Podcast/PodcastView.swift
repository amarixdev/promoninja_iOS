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
    
    var body: some View {
        if  podcast?.sponsors?.count == nil {
            ZStack {
                Rectangle().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                Text("Loading...")
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
                            Group {
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
                                        Rectangle()
                                            .frame(width: 180, height: 180)
                                            .cornerRadius(20)
                                            .foregroundStyle(Color(.systemGray5).gradient)
                                    }
                                  
                                      
                                }
                                .padding(.bottom, 15)
                                VStack {
                                    if let publisher = podcast?.publisher {
                                        Text((publisher.truncated(maxLength: 35)))
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.gray)
                                    }
                                   
                                }
                            }
                            
                            //Buttons
                            HStack {
                                Button {
                                  
                                } label: {
                                    Text( podcast?.category?[0]?.name ?? "")
                                        .foregroundStyle(.white)
                                        .font(.subheadline.bold())
                                      
                                }
                                .buttonStyle(.bordered)
                                Button {
                                  
                                } label: {
                                    Text("Share")
                                        .foregroundStyle(.white)
                                        .font(.subheadline.bold())
                                      
                                }
                                .buttonStyle(.bordered)
                          
                            }
                            .padding(.top)
                           
                            //Sponsors
                  
                            SponsorListView(podcast: podcast)
                        
                            Spacer()
                        }
                    }
              
                    .padding()
                   
                    
                    
                }
                .navigationTitle(podcast?.title ?? "")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarTitleDisplayMode(.inline)
                .tint(.white)
           
             
        }
        
        
    
 
    }
}

#Preview {
    PodcastView( title: "Aubrey Marcus Podcast")
        .preferredColorScheme(.dark)
}
