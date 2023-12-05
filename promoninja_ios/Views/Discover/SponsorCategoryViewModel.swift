//
//  SponsorCategoryViewModel.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI
import PromoninjaSchema

class SponsorCategoryViewModel:ObservableObject {
    
    
    @Published var categoryData: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?]?
     
    init () {
        getSponsorCategoryData()
    }
    
    func getSponsorCategoryData () {
        Network.shared.apollo.fetch(query: GetSponsorCategoriesQuery()) { result in
            guard let data = try? result.get().data else { return }
            
            if let categoryData = data.getSponsorCategories {
                DispatchQueue.main.async {
                    self.categoryData = categoryData
                    
                }
            }
        }
    }
    
}
