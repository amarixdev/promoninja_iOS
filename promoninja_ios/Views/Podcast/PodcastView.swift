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
    
    var body: some View {
        if podcast?.title == nil {
            ZStack {
                Rectangle().frame(width: .infinity, height: .infinity)
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                Text("Loading...")
            }
        } else {
          
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [podcastTheme, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        
                   ScrollView {
                        VStack {
                            AsyncImage(
                                url: URL(string: podcast?.imageUrl ?? "")
                            ) { image in
                                image.image?.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 225, height: 225)
                                    .cornerRadius(20)
                                  
                            }
                            .padding(.bottom, 15)
                            VStack {
                                Text((podcast?.publisher!)!)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                            }
                            
                            //Buttons
                            HStack {
                                Button {
                                  
                                } label: {
                                    Text(podcast?.category?[0]?.name ?? "")
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
                  
                            VStack(spacing: 10) {
                                    ForEach(podcast?.sponsors ?? [], id:\.self) {
                                        sponsor in
                                        
                                        NavigationLink(value: sponsor)  {
                                                HStack(spacing: 30) {
                                                    AsyncImage(url: URL(string: sponsor?.imageUrl ?? "")) {
                                                        image in
                                                        image.image?.resizable()
                                                            .frame(width: 50, height: 50)
                                                            .cornerRadius(10)
                                                    
                                                    }
                                                    
                                                    
                                                    
                                                    VStack(alignment:.leading) {
                                                        if let sponsor = sponsor {
                                                            Text(sponsor.name ?? "")
                                                                .font(.caption.bold())
                                                                .foregroundStyle(.white)
                                                        }
                                                        if let url = sponsor?.url {
                                                            Text(url)
                                                                .font(.caption.bold())
                                                                .foregroundStyle(.gray)
                                                        }
                                                    }
                                                    Spacer()
                                                }
//                                                .onTapGesture {
//                                                    path.append(sponsor)
//                                                }
                                            }
                                        
                                            Divider()
                                         
                                    }
                                }
                                .padding()
                        
                            Spacer()
                        }
                    }
              
                    .padding()
                   
                    
                    
                }
                .navigationTitle(podcast?.title ?? "")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarTitleDisplayMode(.inline)
           
             
        }
        
        
    
 
    }
}

//#Preview {
//    PodcastView( title: "kill tony")
//        .preferredColorScheme(.dark)
//}
