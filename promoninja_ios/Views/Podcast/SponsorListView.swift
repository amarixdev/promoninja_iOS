//
//  SponsorList.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct SponsorListView: View {
    let podcast: GetPodcastQuery.Data.GetPodcast?
    @State private var displaySheet = false
    @State private var selectedSponsor: GetPodcastQuery.Data.GetPodcast.Sponsor?
    
    @State private var amount = 0.0
    
    init (podcast: GetPodcastQuery.Data.GetPodcast? ) {
        self.podcast = podcast
        self._selectedSponsor = State(wrappedValue: podcast?.sponsors?[0])
    }
    
    var body: some View {
        VStack(spacing:0) {
                ForEach(podcast?.sponsors ?? [], id:\.self) {
                    sponsor in
                            Divider()
                                ZStack {
                                    Color(.clear )
                               
                                        .opacity(0.2)
                                        .frame(height: 80)
                                        .ignoresSafeArea(.all)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            selectedSponsor = sponsor
                                            displaySheet = true
                                            
                                        }
                                       
                                      
                                    
                                    
                                      
                                    HStack(spacing: 15) {
                                        if let index = podcast?.sponsors?.firstIndex(of: sponsor) {
                                            Text(String (index + 1))
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                                .padding(.leading)
                                        }
                                        LazyImage(url: URL(string: sponsor?.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)) {
                                            phase in
                                            if let image = phase.image {
                                                image.resizable()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(10)
                                            } else {
                                                Placeholder(frameSize: 50, imgSize: 20, icon: .sponsor)
                                            }
                                           
                                        
                                        }
                                        VStack(alignment:.leading) {
                                            if let name = sponsor?.name {
                                                Text(name.truncated(25) )
                                                    .font(.caption)
                                                    
                                                    .foregroundStyle(.white)
                                            }
                                            if let url = sponsor?.url {
                                                Text(url.truncated(25))
                                                    .font(.caption)
                                                    
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                        Spacer()
                                    }
                                   
                                }
                                .sheet(isPresented: $displaySheet) {
                                    ZStack {
                                        LinearGradient(colors: [Color(.sponsorTheme).opacity(0.85), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom)
                                            .ignoresSafeArea(.all)
                                        SponsorDetailSheet(podcast: podcast , sponsor: $selectedSponsor)
                                            .presentationDetents([.medium, .large])
                                            .presentationBackground(.clear)

                                    }
                             
                                }
                              
                                
                                
                        Divider()
                    
                     
                }
          
            }
        .padding(.vertical)
    }
}

