//
//  FavoritePodcasts.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/3/24.
//

import SwiftUI
import SwiftData
import ApolloAPI
import NukeUI

struct FavoritePodcastsView: View {
    let favoritePodcasts: [FavoritePodcast]
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    
    var filteredPodcasts: [FavoritePodcast] {
        if searchText.isEmpty {
            return favoritePodcasts
        } else {
            return favoritePodcasts.filter { podcast in
                guard let podcast = podcast.title else { return false}
                
                return podcast.localizedCaseInsensitiveContains(searchText)
                
            }
        }
    }
    
    var body: some View {
        ZStack {
            GradientView()
            if favoritePodcasts.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tap the ")
                        Image(systemName: "heart")
                        Text("icon to favorite a podcast")
                    }
                    .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.top, 50)
                .frame(width: UIScreen.main.bounds.width, alignment:.center)
                
            } else {
                VStack {
                        List {
                            ForEach(filteredPodcasts) { podcast in
                                NavigationLink(value: podcast) {
                                    HStack(spacing: 15) {
                                        LazyImage(url: URL(string: podcast.image ?? "")) {
                                            phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .frame(width: 70, height: 70)
                                                    .cornerRadius(10)
                                                    .shadow(color:.black, radius: 5)
                                            } else {
                                                Placeholder(frameSize: 70, imgSize: 45, icon: .podcast)
                                            }
                                        }
                                        
                                        VStack(alignment:.leading) {
                                            Text(podcast.title?.truncated(30) ?? "")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                            Text(podcast.publisher?.truncated(30) ?? "")
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .ignoresSafeArea()
                                    .padding(.vertical, 10)
                                }
                                .listRowBackground(Color.sponsorTheme.opacity(0.25))
                            }
                            .onDelete(perform: deleteOffer)
                        }
                      
                        .listStyle(.plain)
                }
                .padding(.top, 20)
            }
           
            
        }
        .searchable(text: $searchText)
        .navigationTitle("Favorite Podcasts")
        .toolbar {
            if !favoritePodcasts.isEmpty {
                EditButton()
            }
        }
        .toolbarStyle(inline: false)
    }
    
   
    
    func deleteOffer(offsets: IndexSet) {
        for offset in offsets {
            let podcast = favoritePodcasts[offset]
            modelContext.delete(podcast)
        }
    }
}



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: FavoritePodcast.self, configurations: config)
     
        
        let crimeJunkie = FavoritePodcast(title: "Crime Junkie", image: "https://i.scdn.co/image/ab6765630000ba8af4ee04946306cf39d230a073", publisher: "audiochuck")
        
        let jre = FavoritePodcast(title: "The Joe Rogan Experience", image: "https://i.scdn.co/image/9af79fd06e34dea3cd27c4e1cd6ec7343ce20af4", publisher: "Joe Rogan")
        
        let samplePodcasts = [crimeJunkie, jre]
             
        
        
        
   return
        NavigationStack {
           FavoritePodcastsView(favoritePodcasts: samplePodcasts)
                .preferredColorScheme(.dark)
                .modelContainer(container)
        }
      
        
        
        
    } catch  {
        return Text("No Data error: \(error.localizedDescription)")
    }
   
    
    
}
