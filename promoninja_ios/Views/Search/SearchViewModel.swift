//
//  SearchViewModel.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/7/23.
//

import Foundation
import PromoninjaSchema
import Fuse
import Combine


enum Category: String {
    case Podcast
    case Sponsor
}

@MainActor
class SearchViewModel: ObservableObject {

    @Published var searchText = ""
    
    @Published var filteredPodcasts = [GetPodcastsQuery.Data.GetPodcast?]()
    @Published var filteredSponsors = [GetSponsorsQuery.Data.GetSponsor?]()
    @Published var currentCategory:Category = .Sponsor {
        didSet {
            if currentCategory == .Sponsor {
                sponsor_filterSearch(searchText: self.searchText)
            } else if currentCategory == .Podcast {
                podcast_filterSearch(searchText: self.searchText)
            }
        }
    }

    @Published var podcasts = [GetPodcastsQuery.Data.GetPodcast?]()
    @Published var sponsors = [GetSponsorsQuery.Data.GetSponsor?]()

    private var cancellables = Set<AnyCancellable>()

    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                if self?.currentCategory == .Podcast {
                    self?.podcast_filterSearch(searchText: searchText)
                }
                
                if self?.currentCategory == .Sponsor {
                    self?.sponsor_filterSearch(searchText: searchText)
                }
            }
            .store(in: &cancellables)
    }
    
 
    
    
    
    
    init() {
        getPodcastsData()
        getSponsorsData()
        addSubscribers()

    }
 
    

    private func sponsor_filterSearch (searchText: String) {
        guard !searchText.isEmpty else {
            filteredSponsors = []
            return
        }
        
        let fuseScore = 0.5
        
         let fuse = Fuse()
         let filteredResults =  sponsors.filter { sponsor in
             var bool = Bool()
             let result = fuse.search(self.searchText, in: sponsor?.name ?? "")
             if let score = result?.score {
                 bool = score < fuseScore
             }
                 return bool
           }
        
        let sortedResults = filteredResults.sorted { (sponsor1, sponsor2) in
                      
             let score1 = fuse.search(self.searchText, in: sponsor1?.name ?? "")?.score
             let score2 = fuse.search(self.searchText, in: sponsor2?.name ?? "")?.score
             return score1 ?? 1 < score2 ?? 1
         }
        
        DispatchQueue.main.async {
            self.filteredSponsors = Array(sortedResults.prefix(6))
        }

     }
    
    
    
    
    private func podcast_filterSearch (searchText: String) {
        guard !searchText.isEmpty else {
            filteredPodcasts = []
            return
        }
       
        let fuseScore = 0.5
        
        //filter logic
            
        let fuse = Fuse()
        var filteredResults =  podcasts.filter { podcast in
            let titleScore = fuse.search(self.searchText, in: podcast?.title ?? "")
            let publisherScore = fuse.search(self.searchText, in: podcast?.publisher ?? "")
            var isTitleMatch = Bool()
            var isPublisherMatch = Bool()
            
            if let titleScore = titleScore?.score {
                isTitleMatch = titleScore < fuseScore
            }
            
            if let publisherScore = publisherScore?.score {
                isPublisherMatch = publisherScore < fuseScore
            }
       
                return isTitleMatch || isPublisherMatch
          }
       
       filteredResults.sort { podcast1, podcast2 in
           
           let score1 = fuse.search(self.searchText, in: podcast1?.title ?? "")?.score
           let score2 = fuse.search(self.searchText, in: podcast2?.title ?? "")?.score

           return  score1 ?? 1 < score2 ?? 1
           
       }
        DispatchQueue.main.async {
            self.filteredPodcasts = Array(filteredResults.prefix(6))
        }
       
    }
    
    
    private func getPodcastsData () {
           Network.shared.apollo.fetch(query: GetPodcastsQuery()) { result in
               guard let data = try? result.get().data else { return }
               if let podcastsData = data.getPodcasts {
            
                       self.podcasts = podcastsData
                   
               }
           }
       }
       
       
    private func getSponsorsData () {
        Network.shared.apollo.fetch(query: GetSponsorsQuery(input: GraphQLNullable (Pagination(offset: 0, pageSize: 0, offerPage: false, path: false)))) { result in
               guard let data = try? result.get().data else { return }
               
            if let sponsorsData = data.getSponsors {
                       self.sponsors = sponsorsData
               }
           }
       }
}
