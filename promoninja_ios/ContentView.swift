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
                    Text("Home Screen")
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
