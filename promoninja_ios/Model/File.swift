//
//  File.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import Foundation
import PromoninjaSchema


//struct Podcast:Hashable {
//    
//  var title: String
//  var imageUrl: String
//  var category: [GetPodcastQuery.Data.GetPodcast.Category?]
//  var sponsors: [GetPodcastQuery.Data.GetPodcast.Sponsor?]
//  var offers: [GetPodcastQuery.Data.GetPodcast.Offer?]
//  var publisher: String
//  var description: String
//  var backgroundColor: String
//    
//    // Implementing custom hash(into:) method
//       func hash(into hasher: inout Hasher) {
//           // Combine the hash values of the properties that contribute to the identity of the instance
//           hasher.combine(title)
//           hasher.combine(imageUrl)
//           hasher.combine(publisher)
//           hasher.combine(description)
//           hasher.combine(backgroundColor)
//           
//           // Combine the hash values of non-conforming type using their properties
//           for categoryItem in category {
//               hasher.combine(categoryItem?.name)
//               // You can include more properties of the Category type if needed
//           }
//           
//           for sponsor in sponsors {
//               hasher.combine(sponsor?.name)
//               hasher.combine(sponsor?.imageUrl)
//               hasher.combine(sponsor?.url)
//               hasher.combine(sponsor?.summary)
//               hasher.combine(sponsor?.offer)
//           }
//       }
//    
//    static func ==(lhs: Podcast, rhs: Podcast) -> Bool {
//           // Compare all properties for equality
//           return lhs.title == rhs.title &&
//                  lhs.imageUrl == rhs.imageUrl &&
//                  lhs.category == rhs.category &&
//                  lhs.publisher == rhs.publisher &&
//                  lhs.description == rhs.description &&
//                  lhs.backgroundColor == rhs.backgroundColor 
//       }
//    
//}



struct Offer {
    
 var sponsor: String
 var promoCode: String
 var url: String
   
}


struct Sponsor: Hashable {
    var name: String
    var imageUrl: String
    var url: String
    var summary: String
    var offer: String
    var podcast: [GetSponsorQuery.Data.GetSponsor.Podcast?]
    var sponsorCategory: [GetSponsorQuery.Data.GetSponsor.SponsorCategory?]
}



struct SponsorCategory {
  var name: String!
  var sponsor: [Sponsor]
    
}


struct Category {
 var id: String
 var name: String
 var podcastId: [String]
}


//struct HashableSponsorData {
//    let sponsorData: SponsorData
//
//    init(_ sponsorData: SponsorData) {
//        self.sponsorData = sponsorData
//    }
//}
