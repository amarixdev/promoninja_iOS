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


extension Binding {
    
    func onUpdate(_ closure: @escaping (_ oldValue: Value, _ newValue: Value) -> Void) -> Binding<Value> {
        Binding {
            wrappedValue
        } set: { newValue in
            let oldValue = wrappedValue
            wrappedValue = newValue
            closure(oldValue, newValue)
        }
    }
}

struct ContentView: View {
    @StateObject var router = Router.router
    @StateObject var selectedTab = CurrentTab()
    @State private var previousTab = ""
    @State var shouldScrollToTop_home = false
    @State var shouldScrollToTop_discover = false

    

    var body: some View {

        TabView(selection: $selectedTab.name.onUpdate { oldValue, newValue in
            //handle tabIcon navigation functionality
           
            if oldValue == newValue {
              
                if newValue == "home" {
                    if router.homePath.count == 0  {
                        shouldScrollToTop_home = true
                    } else {
                        router.homePath.removeLast(router.homePath.count)
                    }
                
                } else if
                    newValue == "discover" {
                    if router.discoverPath.count == 0 {
                        shouldScrollToTop_discover = true
                    } else {
                        router.discoverPath.removeLast(router.discoverPath.count)

                    }
                }
                
               
            }
            
           
            
            
                    
        }) {
            NavigationStack(path: $router.homePath) {
                HomeScreen(shouldScrollToTop: $shouldScrollToTop_home)
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
                    DiscoverView(shouldScrollToTop: $shouldScrollToTop_discover)
                
                }
                .tabItem {
                    Image(systemName: "circle.grid.2x2")
                 
                }
                .tag("discover")
                .onTapGesture {
                    selectedTab.name = "discover"
                }
               
                //1.TODO clear path when icon is clicked; 2. Search page

             
            }
    
        .environmentObject(selectedTab)
        .tint(.white)
        }

    

}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
