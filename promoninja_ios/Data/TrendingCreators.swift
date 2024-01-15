//
//  TrendingCreators.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/29/23.
//

import Foundation
import SwiftUI
import PromoninjaSchema

let trendingCreators: [String: [String: (ImageResource, [String], String)]] = [
    
    "comedy": [
        "Joe Rogan": (.rogan, ["The Joe Rogan Experience"], comedySummary["Joe Rogan"]!),
        "Theo Von": (.theo, ["This Past Weekend"], comedySummary["Theo Von"]!),
        "Bobby Lee": (.bobby, ["TigerBelly", "Bad Friends"],  comedySummary["Bobby Lee"]!),
        "Andrew Schulz": (.schulz, ["Andrew Schulz's Flagrant with Akaash Singh", "The Brilliant Idiots"], comedySummary["Andrew Schulz"]! ),
//        "Duncan Trussel": (.duncan, ["Duncan Trussell Family Hour"], comedySummary["Duncan Trussel"]!),
        "Charlamagne": (.charla, ["The Brilliant Idiots"], comedySummary["Charlamagne Da God"]! ),
        "Tom Segura": (.tom, ["Your Mom's House with Christina P. and Tom Segura", "2 Bears, 1 Cave with Tom Segura & Bert Kreischer"], comedySummary["Tom Segura"]!),
        "Andrew Santino": (.santino, ["Whiskey Ginger with Andrew Santino", "Bad Friends"], comedySummary["Andrew Santino"]!),
        "Bobbi Althoff": (.bobbi, ["The Really Good Podcast"], comedySummary["Bobbi Althoff"]!)
    ],
    
    "society & culture": [
        "Violet Benson": (.violet, ["Almost Adulting with Violet Benson"], societySummary["Violet Benson"]!),
        "Nick Viall": (.viall, ["The Viall Files"], societySummary["Nick Viall"]!),
        "Alex Cooper": (.alexcooper, ["Call Her Daddy"], societySummary["Alex Cooper"]!),
        "Aubrey Marcus": (.aubrey, ["Aubrey Marcus Podcast"], societySummary["Aubrey Marcus"]!),
        "Kid Fury": (.fury, ["The Read"], societySummary["Kid Fury"]!),
        "Kelsey McKinney": (.kelsey, ["Normal Gossip"], societySummary["Kelsey McKinney"]!)
    ],
    
    
    "educational": [
        "Andrew Huberman": (.huberman, ["Huberman Lab"], educationalSummary["Andrew Huberman"]!),
        "LeVar Burton": (.levar, ["LeVar Burton Reads"], educationalSummary["LeVar Burton"]!),
        "Ramit Sethi": (.ramit, ["I Will Teach You To Be Rich"], educationalSummary["Ramit Sethi"]!),
        "Guy Raz": (.guy, ["How I Built This with Guy Raz"], educationalSummary["Guy Raz"]!),
    ],
    
    
    "sports": [
        "Travis Kelce": (.kelce, ["New Heights with Jason and Travis Kelce"], sportsSummary["Travis Kelce"]!),
        "Paul George": (.pg, ["Podcast P with Paul George"], sportsSummary[ "Paul George"]!),
        "Bomani Jones": (.bomani, ["The Right Time with Bomani Jones"], sportsSummary["Bomani Jones"]!),
        "Shannon Sharpe": (.shannon, ["Nightcap with Unc and Ocho", "Club Shay Shay"], sportsSummary["Shannon Sharpe"]!)
    ],
    
    
    "technology": [
        "Lex Fridman": (.lex, ["Lex Fridman Podcast"], technologySummary["Lex Fridman"]!),
        "Scott Galloway": (.galloway, ["Pivot"], technologySummary["Scott Galloway"]!)
    ],
    
    
    "true crime": [
        "Henry Zebrowski": (.henry, ["Last Podcast On The Left"], true_crime["Henry Zebrowski"]!),
        "Bailey Sarian": (.bailey, ["Murder, Mystery & Makeup"], true_crime["Bailey Sarian"]!),
        "Ashley Flowers": (.ashley, ["Crime Junkie"], true_crime["Ashley Flowers"]!)
        
    ]
    
    
    
]



func getCreators (category: String) -> [Creator] {
    guard let trendingCreators = trendingCreators[category] else { return [] }
    
    var creators = [Creator]()
    
    for (fullName, resource) in trendingCreators {
        creators.append(Creator(fullName: fullName, image: resource.0, podcasts: resource.1, summary: resource.2))
    }
    
    return creators
}


struct Creator:Hashable {
    let fullName: String
    let image: ImageResource
    let podcasts: [String]
    let summary: String
    
    var multiplePodcasts: Bool {
        podcasts.count > 1
    }
    
}
