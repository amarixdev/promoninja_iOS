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
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("Home Screen")
                }
                .tabItem {
                    Text("Home")
                }
                .tag(0)
                
                SponsorView(name: "Athletic Greens")
                    .tabItem {
                        Text("Sponsor")
                    }
                    .tag(1)
            }
        }
       
        
    }

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
