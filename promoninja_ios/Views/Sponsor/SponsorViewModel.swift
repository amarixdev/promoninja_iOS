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
    @Published var trendingSponsors = [[GetSponsorQuery.Data.GetSponsor?]()]
    
   
    init (name: String) {
        getSponsorData(name: name)
        getTrendingSponsors()
    }
    
    func getSponsorData (name: String) {
        Network.shared.apollo.fetch(query: GetSponsorQuery(input: SponsorInput(name: name))) { result in

            guard let data = try? result.get().data else { return }
            if let sponsorData = data.getSponsor {
                
                
                DispatchQueue.main.async {
                    self.sponsorData = sponsorData
                    
                }
            }
        }
        
    }
    
    private func getTrendingSponsors() {
        var previousGroup = SponsorGroup(title: "", sponsorNames: [""])
        var result = [[GetSponsorQuery.Data.GetSponsor?]]()
        let dispatchGroup = DispatchGroup()

        for sponsorGroup in sponsorGroups {
            var groupData = [GetSponsorQuery.Data.GetSponsor?]()
            let currentGroup = sponsorGroup
            
            
            for sponsorName in sponsorGroup.sponsorNames {
                dispatchGroup.enter()

                Network.shared.apollo.fetch(query: GetSponsorQuery(input: SponsorInput(name: sponsorName))) { result in
                    defer {
                        dispatchGroup.leave()
                    }

                    guard let data = try? result.get().data else { return }
                    if let sponsorData = data.getSponsor {
                        if currentGroup.title != previousGroup.title {
                            groupData.append(sponsorData)
                        }
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                // This block will be executed when all asynchronous operations are complete
                result.append(groupData)
                groupData.removeAll()
                previousGroup = currentGroup
                
                // Perform any actions that depend on the result, e.g., update UI
                self.trendingSponsors = result
            }
        }
    }


}


