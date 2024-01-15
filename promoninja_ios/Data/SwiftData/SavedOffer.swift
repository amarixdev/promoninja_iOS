//
//  ProfileData.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/31/23.
//

import Foundation
import SwiftData



@Model class SavedOffer: Hashable {
    struct Podcast: Codable, Hashable  {
        var title: String?
        var image: String?
        var publisher: String?
    }
    
    
    struct Sponsor: Codable, Hashable {
        var name: String?
        var category: String?
        var image: String?
    }
    
    var podcast: Podcast
    var sponsor: Sponsor
    var offer: String?
    
    init(podcast: Podcast, sponsor: Sponsor, offer: String? = nil) {
        self.podcast = podcast
        self.sponsor = sponsor
        self.offer = offer
    }
  
}

