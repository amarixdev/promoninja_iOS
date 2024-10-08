//
//  TrendingSponsors.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/1/23.
//

import Foundation



struct SponsorGroup: Hashable {
    let title: String
    let sponsorNames: [String]
}


let supplements = SponsorGroup(title: "Fuel Your Body", sponsorNames: ["Liquid IV" , "Athletic Greens", "Nutrisense"]) //MUDWTR
let skinCare = SponsorGroup(title: "Revitalize Your Skin", sponsorNames: ["Apostrophe", "One Skin", "IPSY"])
let mentalHealth = SponsorGroup(title: "Find Inner Peace", sponsorNames: ["Better Help", "HeadSpace", "Talkspace"])
let homeCare = SponsorGroup(title: "Soothe and Sleep", sponsorNames: ["Eight Sleep", "Helix Mattress", "Brooklinen"])
let underwear = SponsorGroup(title: "Luxe Beneath Layers", sponsorNames: ["MeUndies", "HoneyLove", "Sheath Underwear"])
let maleProducts = SponsorGroup(title: "Gifts For Dad", sponsorNames: ["True Classic", "Manscaped", "Keeps"])
let reproductive = SponsorGroup(title: "Sexual and Reproductive", sponsorNames: ["BLUECHEW", "Wisp", "Mochi Melt"])

let sponsorGroups = [supplements, skinCare, homeCare, mentalHealth, underwear, maleProducts, reproductive]
