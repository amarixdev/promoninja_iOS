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
    
    init(title: String?, image: String?, publisher: String?) {
        self.title = title
        self.image = image
        self.publisher = publisher
    }
}


