//
//  SponsorViewModel.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema




class SponsorViewModel:ObservableObject {
    
    @Published var sponsorData: GetSponsorQuery.Data.GetSponsor?
     
    init (name: String) {
        getSponsorData(name: name)
    }
    
    func getSponsorData (name: String) {
        Network.shared.apollo.fetch(query: GetSponsorQuery(input: SponsorInput(name: name))) { result in

            guard let data = try? result.get().data else { return }
            if let sponsorData = data.getSponsor {
                
                
                DispatchQueue.main.async {
//                    self.sponsorData = Sponsor(name: sponsorData.name!, imageUrl: sponsorData.imageUrl!, url: sponsorData.url!, summary: sponsorData.summary!, offer: sponsorData.offer!, podcast: sponsorData.podcast! , sponsorCategory: sponsorData.sponsorCategory!)
                   
                    self.sponsorData = sponsorData
                    
                }
            }
        }
        
    }
    
//   private func populatePodcasts (podcasts: [GetSponsorQuery.Data.GetSponsor.Podcast?]) -> [Podcast] {
//     
//     return  podcasts.compactMap { podcast in
//         Podcast(title: podcast?.title ?? "", imageUrl: podcast?.imageUrl ?? "", category: podcast?.category ?? [], sponsors: [], offers: podcast?.offer ?? "", publisher: podcast?.publisher ?? "", description: podcast?.description ?? "", backgroundColor: podcast?.backgroundColor ?? "")
//       }
//       
//   }
//    
//    private func populateSponsors (sponsors: [GetPodcastQuery.Data.GetPodcast.Sponsor]) -> [Sponsor] {
//        return sponsors.map { sponsor in
//            Sponsor(name: sponsor.name ?? "", imageUrl: sponsor.imageUrl ?? "", url: sponsor.url ?? "", summary: sponsor.summary ?? "", offer: sponsor.offer ?? "", podcast: <#T##[Podcast?]#>, sponsorCategory: <#T##[GetSponsorQuery.Data.GetSponsor.SponsorCategory?]#>)
//        }
//    }
//    
//    
//    private func populateCategory (category: [GetPodcastQuery.Data.GetPodcast.Category]) -> [Category] {
//        return category.map { category in
//            Category(id: <#T##String#>, name: <#T##String#>, podcast: <#T##[Podcast]#>)
//        }
//    }
//    
//    
//    private func populateSponsorCategory( sponsorCategory: [GetSponsorQuery.Data.GetSponsor.SponsorCategory?] ) -> [SponsorCategory] {
//        return sponsorCategory.map { sponsorCategory in
//            SponsorCategory(name: <#T##String?#>, sponsor: <#T##[Sponsor]#>)
//            
//        }
//    }
    
}


