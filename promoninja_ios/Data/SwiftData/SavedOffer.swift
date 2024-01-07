//
//  ProfileData.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/31/23.
//

import Foundation
import SwiftData



@Model class SavedOffer {
    struct Podcast: Codable  {
        var title: String?
        var image: String?
        var publisher: String?
    }
    
    var podcast: Podcast
    var sponsor: String?
    var offer: String?
    var category: String?
    
    init(podcast: Podcast, sponsor: String?, offer: String?, category: String?) {
        self.podcast = podcast
        self.sponsor = sponsor
        self.offer = offer
        self.category = category
    }
}

