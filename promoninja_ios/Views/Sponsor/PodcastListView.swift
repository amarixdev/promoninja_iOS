//
//  Podcasts.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct PodcastListView: View {
    
    let sponsor: GetSponsorQuery.Data.GetSponsor?
    @State private var displaySheet = false
    @State private var selectedPodcast: GetSponsorQuery.Data.GetSponsor.Podcast?
    @State private var podcastTheme: Color = Color(.black)
    
    @State private var displayReport = false


    init (sponsor: GetSponsorQuery.Data.GetSponsor? ) {
        self.sponsor = sponsor
        self._selectedPodcast = State(wrappedValue: (sponsor?.podcast?[0])!)
    }
    

    
    var body: some View {
        VStack(spacing:0) {
                ForEach(sponsor?.podcast ?? [], id:\.self) {
                    podcast in
                    Divider()
                                ZStack {
                                
                                    Color(.clear)
                                        .opacity(0.2)
                                        .frame(height: 80)
                                        .ignoresSafeArea(.all)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            selectedPodcast = podcast
                                
                                            
                                            if let backgroundColor = podcast?.backgroundColor {
                                                podcastTheme = Color(rgbString: backgroundColor)                  
                                            }
                                            
                                            displaySheet = true
                                           
                                        }
                                        .onChange(of: podcastTheme) {
                                            if selectedPodcast == sponsor?.podcast?[0] {
                                                displaySheet = true
                                            }

                                        }
                                  
                                    
                                      
                                    HStack(spacing: 15) {
                                        if let index = sponsor?.podcast?.firstIndex(of: podcast) {
                                            Text(String (index + 1))
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                                .padding(.leading)
                                        }
                                        LazyImage(url: URL(string: podcast?.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)) {
                                            phase in
                                            if let image = phase.image {
                                                image.resizable()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(10)
                                            } else {
                                                Placeholder(frameSize: 50, imgSize: 20, icon: .podcast)
                                            }
                                            
                                            
                                        }
                                        .onTapGesture {
                                            selectedPodcast = podcast
                                
                                            
                                            if let backgroundColor = podcast?.backgroundColor {
                                                podcastTheme = Color(rgbString: backgroundColor)
                                            }
                                            
                                            displaySheet = true
                                           
                                        }
                                        
                                        VStack(alignment:.leading) {
                                            if let title = podcast?.title {
                                                Text(title)
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .lineLimit(1)
                                            }
                                            if let publisher = podcast?.publisher {
                                                Text(publisher)
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                                    .lineLimit(1)
                                            }
                                        }
                                        .padding(.trailing, 20)
                                        Spacer()
                           
                                        
                                        
                                    }
                                    
                                    
                               
                                   
                                }
                        

                                .sheet(isPresented: $displaySheet) {
                                    
                                     ZStack {
                                         LinearGradient(gradient: Gradient(colors: [podcastTheme.opacity(0.8), .black.opacity(0.95), .black]), startPoint: .top, endPoint: .bottom)
                                             .ignoresSafeArea(.all)
                                        
                                        PodcastDetailSheet(podcast: $selectedPodcast, sponsor: sponsor)
                                             .presentationDetents([.medium, .large])
                                             .presentationBackground {
                                                 Color.clear
                                             }
                                             .environment(\.colorScheme, .dark)
                                             
    
                                    }
                             
                                }
                              
                               
                                
                               
                        Divider()
                     
                }
            }
    
           
       
        .padding(.vertical)
    }
}

//#Preview {
//    SponsorListView(po)
//}





//#Preview {
//    Podcasts()
//}
