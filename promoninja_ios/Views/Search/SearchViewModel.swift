//
//  SearchViewModel.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/7/23.
//

import Foundation
import PromoninjaSchema
import Fuse


class SearchViewModel: ObservableObject {
    enum Category: String {
        case Podcast
        case Sponsor
    }
    
    
    @Published var searchText = "" {
        didSet {
   
                if currentCategory == .Podcast {
              
                    podcast_filterSearch()
                } else if currentCategory == .Sponsor {
                 
                    sponsor_filterSearch()
                }
           
        }
    }
    
   
    
    @Published var currentCategory:Category = .Podcast {
        didSet {
            if currentCategory == .Podcast {
          
                podcast_filterSearch()
            } else if currentCategory == .Sponsor {
             
                sponsor_filterSearch()
            }
        }
    }
    
    @Published var podcasts = [GetPodcastsQuery.Data.GetPodcast?]()
    @Published var sponsors = [GetSponsorsQuery.Data.GetSponsor?]()

    @Published var filteredPodcasts = [GetPodcastsQuery.Data.GetPodcast?]()
    @Published var filteredSponsors = [GetSponsorsQuery.Data.GetSponsor?]()

    
    init() {
        getPodcastsData()
        getSponsorsData()

    }

    
 private  func getPodcastsData () {
     print("gettingData..")
        Network.shared.apollo.fetch(query: GetPodcastsQuery()) { result in
            guard let data = try? result.get().data else { return }
            
            if let podcastsData = data.getPodcasts {
                DispatchQueue.main.async {
                        
                    self.podcasts = podcastsData
                    
                }
            }
        }
    }
    
    
 private func getSponsorsData () {
     Network.shared.apollo.fetch(query: GetSponsorsQuery(input: GraphQLNullable (Pagination(offset: 0, pageSize: 0, offerPage: false, path: false)))) { result in
            guard let data = try? result.get().data else { return }
            
         if let sponsorsData = data.getSponsors {
                DispatchQueue.main.async {
                        
                    self.sponsors = sponsorsData
                    
                }
            }
        }
    }
    
    private func sponsor_filterSearch () {
         let fuse = Fuse()
        
         let filteredResults =  sponsors.filter { sponsor in
             var bool = Bool()
             let result = fuse.search(self.searchText, in: sponsor?.name ?? "")
             if let score = result?.score {
                 bool = score < 0.5
             }
                 return bool
           }
        
        let sortedResults = filteredResults.sorted { (sponsor1, sponsor2) in
                      
             let score1 = fuse.search(self.searchText, in: sponsor1?.name ?? "")?.score
             let score2 = fuse.search(self.searchText, in: sponsor2?.name ?? "")?.score
             return score1 ?? 1 < score2 ?? 1
         }
        
        print(sortedResults)
        
         
         self.filteredSponsors = sortedResults

     }
    
    
    
    
   private func podcast_filterSearch () {
        let fuse = Fuse()
       
       var filteredResults =  podcasts.filter { podcast in
            let titleScore = fuse.search(self.searchText, in: podcast?.title ?? "")
            let publisherScore = fuse.search(self.searchText, in: podcast?.publisher ?? "")
            var isTitleMatch = Bool()
            var isPublisherMatch = Bool()
            
            if let titleScore = titleScore?.score {
                isTitleMatch = titleScore < 0.5
            }
            
            if let publisherScore = publisherScore?.score {
                isPublisherMatch = publisherScore < 0.5
            }
            
       
                return isTitleMatch || isPublisherMatch
          }
       
       
 
       filteredResults.sort { podcast1, podcast2 in
           
           let score1 = fuse.search(self.searchText, in: podcast1?.title ?? "")?.score
           let score2 = fuse.search(self.searchText, in: podcast2?.title ?? "")?.score

            
           return  score1 ?? 1 < score2 ?? 1
           
       }
       
        
        self.filteredPodcasts = filteredResults
       

    }
    
}
