//
//  PodcastCategoryViewModel.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import Foundation
import PromoninjaSchema


class PodcastCategoryViewModel:ObservableObject {
    
    @Published var currentCategory: String? = "comedy" {
            didSet {
                getCategoryPodcasts(for: currentCategory ?? "comedy")
            }
    }
    
    @Published var categoryData: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?]?
    @Published var podcasts = [GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]()
    @Published var podcastCategory: GetPodcastCategoriesQuery.Data.GetPodcastCategory??
     
    init () {
        getPodcastCategoryData()
    }
    
    func getPodcastCategoryData () {
        Network.shared.apollo.fetch(query: GetPodcastCategoriesQuery()) { result in
            guard let data = try? result.get().data else { return }
            if let categoryData = data.getPodcastCategories {
                DispatchQueue.main.async {
                    self.categoryData = categoryData
                    self.getCategoryPodcasts(for: "comedy")
                }
            }
        }
    }
    
    func getCategoryPodcasts (for categoryName: String)  {
        let category = self.categoryData?.first(where: { category in
              category?.name == categoryName
          })
        DispatchQueue.main.async {
            self.podcasts = category??.podcast ?? []
            self.podcastCategory = category
        }
    
    }
    
    
    
    
}
