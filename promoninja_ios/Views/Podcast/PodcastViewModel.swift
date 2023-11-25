//
//  PodcastViewController.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema


class PodcastViewModel:ObservableObject {
    
    
    @Published var podcastData: GetPodcastQuery.Data.GetPodcast?
     
    init (title: GraphQLNullable<String>) {
        getPodcastData(title: title)
    }
    
    func getPodcastData (title: GraphQLNullable<String>) {
        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
            guard let data = try? result.get().data else { return }
            
            if let podcastData = data.getPodcast {
                DispatchQueue.main.async {
                    self.podcastData = (podcastData)
                }
            }
        }
    }
    
}
