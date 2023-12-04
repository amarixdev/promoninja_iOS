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

            TabView {
                NavigationStack(path: $router.path) {
                    HomeScreen()
                        .tabItem {
                            Text("Home")
                                .foregroundStyle(.white)
                        }
               }
                
             
            }
            
           
        }

    

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
