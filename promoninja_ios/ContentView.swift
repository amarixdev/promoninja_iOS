//
//  ContentView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema


struct ContentView: View {
    @StateObject var router = Router.router
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                VStack {
                    HomeScreenView()
                        
                }
                .tabItem {
                    Text("Home")
                }
                .tag(0)
                
                CreatorsView()
                    .tabItem {
                        Text("Creator")
                    }
                    .tag(1)
            }
            .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor.self) { sponsor in
                if let name = sponsor.name {
                    SponsorView(name: name )
                }
            }
            .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.self) { category in
              
                CategoryView(category: category)
            
            }
            .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast.self) { podcast in
                PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
            }
            
            .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.Podcast.self) { podcast in
                        PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
                    }
            .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.Sponsor.self) { sponsor in
                        SponsorView(name: sponsor.name!)

                    }
            .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.self) { podcast in
                PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))

                    }
        }
        .tint(.clear)
       
        
    }

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
