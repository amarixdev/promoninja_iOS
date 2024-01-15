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
    @State private var selectedPodcast: GetPodcastQuery.Data.GetPodcast?
    
    @State private var amount = 0.0
    
    init (podcast: GetPodcastQuery.Data.GetPodcast? ) {
        self.podcast = podcast
        self._selectedSponsor = State(wrappedValue: podcast?.sponsors?[0])
        self._selectedPodcast = State(wrappedValue: podcast)
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
                                        
                                        
                                        
                                        
                                        LazyImage(url: URL(string: sponsor?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) {
                                            phase in
                                            if let image = phase.image {
                                                image.resizable()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(10)
                                            } else {
                                                Placeholder(frameSize: 50, imgSize: 20, icon: .sponsor)
                                            }
                                           
                                        
                                        }
                                        .onTapGesture {
                                            selectedSponsor = sponsor
                                            displaySheet = true
                                        }

                                        VStack(alignment:.leading) {
                                            if let name = sponsor?.name {
                                                Text(name )
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .lineLimit(1)
                                            }
                                            if let url = sponsor?.url {
                                                Text(url)
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
                                        LinearGradient(colors: [Color(.sponsorTheme).opacity(0.95), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom)
                                     
                                        SponsorDetailSheet(favoritePage:false, podcast: $selectedPodcast , sponsor: $selectedSponsor)
                                            .presentationDetents([.medium, .large])
                                            .presentationBackground(.clear)
                                            .environment(\.colorScheme, .dark)
                                    }
                             
                                }
                              
                                
                                
                        Divider()
                    
                     
                }
          
            }
        .padding(.vertical)
    }
}

