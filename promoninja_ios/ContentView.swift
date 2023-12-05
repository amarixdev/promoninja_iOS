//
//  ContentView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema

//handle back-swipe
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


struct ContentView: View {
    @StateObject var router = Router.router
    
    @StateObject var selectedTab = CurrentTab()
    

    var body: some View {

        TabView(selection: $selectedTab.name) {
            NavigationStack(path: $router.homePath) {
                HomeScreen()
                        .onTapGesture {
                            selectedTab.name = "home"
                        }
                    
                       
               }
                .tabItem {
                    Image(systemName: "house")
                       
                }
                .tag("home")
                .onTapGesture {
                    selectedTab.name = "home"
                }
              
                
                
            NavigationStack(path: $router.discoverPath) {
                    DiscoverView()
                
                }
                .tabItem {
                    Image(systemName: "circle.grid.2x2")
                 
                }
                .tag("discover")
                .onTapGesture {
                    selectedTab.name = "discover"
                }
               
                
             
            }
        .environmentObject(selectedTab)
        .tint(.white)
            
           
        }

    

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
