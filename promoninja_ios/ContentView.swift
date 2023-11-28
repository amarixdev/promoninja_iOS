//
//  ContentView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema


struct ContentView: View {
    @StateObject var router = Router.router
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                VStack {
                    HomeScreenView()
                        .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor.self) { sponsor in
                            if let name = sponsor.name {
                                SponsorView(name: name )
                            }
                        }
                        .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.self) { category in
                          
                            CategoryView(category: category)
                           
                           
                        }
                    
                }
                .tabItem {
                    Text("Home")
                }
                .tag(0)
                
                SponsorView(name: "SquareSpace")
                    .tabItem {
                        Text("Sponsor")
                    }
                    .tag(1)
            }
        }
        .tint(.clear)
       
        
    }

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
