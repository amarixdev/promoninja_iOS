//
//  FavoritePodcast.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/3/24.
//

import Foundation
import SwiftData

@Model
class FavoritePodcast {
    var title: String?
    var image: String?
    var publisher: String?
    var sponsorCount: Int?
    
    init(title: String? = nil, image: String? = nil, publisher: String? = nil, sponsorCount: Int? = nil) {
        self.title = title
        self.image = image
        self.publisher = publisher
        self.sponsorCount = sponsorCount
    }
    
}


