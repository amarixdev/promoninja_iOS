//
//  TrendingCreators.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/29/23.
//

import Foundation
import SwiftUI
import PromoninjaSchema

let trendingCreators: [String: [String: (ImageResource, [String]) ]] = [
    "comedy": [
        "Joe Rogan": (.rogan, ["The Joe Rogan Experience"]),
        "Theo Von": (.theo, ["This Past Weekend"]),
        "Bobby Lee": (.bobby, ["TigerBelly", "Bad Friends"]),
        "Marie Faustin": (.marie, ["The Unofficial Expert with Sydnee Washington and Marie Faustin"]),
        "Andrew Schulz": (.schulz, ["Andrew Schulz's Flagrant with Akaash Singh", "The Brilliant Idiots"]),
        "Duncan Trussel": (.duncan, ["Duncan Trussell Family Hour"]),
        "Charlamagne Da God": (.charla, ["The Brilliant Idiots"]),
        "Tom Segura": (.tom, ["Your Mom's House with Christina P. and Tom Segura", "2 Bears, 1 Cave with Tom Segura & Bert Kreischer"])
    ]
]


//  "Violet Benson": (.violet, ["Almost Adulting with Violet Benson"])

func getCreators (category: String) -> [Creator] {
    guard let trendingCreators = trendingCreators[category] else { return [] }
    
    var creators = [Creator]()
    
    for (fullName, resource) in trendingCreators {
        creators.append(Creator(fullName: fullName, image: resource.0, podcasts: resource.1))
    }
    
    return creators
}


struct Creator:Hashable {
    let fullName: String
    let image: ImageResource
    let podcasts: [String]
    
    var multiplePodcasts: Bool {
        podcasts.count > 1
    }
    
}
