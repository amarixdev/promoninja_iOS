//
//  ProfileView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/3/24.
//

import SwiftUI
import SwiftData
import PromoninjaSchema
import ApolloAPI

struct ProfileView: View {
    
    @Query(sort:[SortDescriptor(\SavedOffer.sponsor)]) var savedOffers: [SavedOffer]
    @Query(sort:[SortDescriptor(\FavoritePodcast.title)]) var favoritePodcasts: [FavoritePodcast]
    
    var body: some View {
        ZStack {
            GradientView()
            
            List {
         
                ForEach(Profile.allCases, id:\.self) { page in
                    NavigationLink(value: page) {
                        HStack {
                            page.label
                        }
                        .padding(.vertical, 10)
                    }

                }
                .listRowBackground(Color.clear)
            }
            .scrollBounceBehavior(.basedOnSize)
            .listStyle(.plain)
        }
        
        .navigationTitle("Profile")
        .navigationDestination(for: Profile.self) { page in
            if page.rawValue == "podcast" {
                FavoritePodcastsView(favoritePodcasts: favoritePodcasts)
            } else {
                SavedOffersView(savedOffers: savedOffers)
            }
        }
        .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
        }
    
    
        .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.Podcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
        }
    
        .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
        }
    
        .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor.self) { sponsor in
            if let name = sponsor.name {
                SponsorView(name: name )
            }
        }
    
        .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.Sponsor.self) { sponsor in
            if let name = sponsor.name {
                SponsorView(name: name)
            }
            
        }
    
        .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.self) { sponsor in
            if let name = sponsor.name {
                SponsorView(name: name)
            }
            
        }
    
        .navigationDestination(for: GetPodcastsQuery.Data.GetPodcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
        }
        .navigationDestination(for: GetSponsorsQuery.Data.GetSponsor.self) { sponsor in
            SponsorView(name: sponsor.name ?? "")
        }
        .navigationDestination(for: FavoritePodcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral: podcast.title ?? "") )
        }
        
        
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .preferredColorScheme(.dark)
    }
   
}
