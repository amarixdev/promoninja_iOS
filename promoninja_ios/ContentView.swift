//
//  ContentView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo
import PromoninjaSchema
import SwiftData

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
    @StateObject var networkManager = NetworkManager()

    @StateObject var router = Router.router
    @StateObject var selectedTab = CurrentTab()
    @State private var previousTab = ""
    @State var shouldScrollToTop_home = false
    @State var shouldScrollToTop_discover = false
    @State var shouldScrollToTop_user = false
   
    @State private var isSplashScreenViewPresented = true

    
    var body: some View {
        if !networkManager.isConnected {
            ZStack {
                GradientView()
                VStack(spacing: 30) {
                    Image(.logo)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .shadow(color: .black, radius: 4, x: 3, y: 4)

                    Text("No Internet Connection")
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
            .preferredColorScheme(.dark)
         
            
            
        } else if isSplashScreenViewPresented {
            SplashScreenView(isPresented: $isSplashScreenViewPresented)
                .preferredColorScheme(.dark)
        }
        else
        
        {
            TabView(selection: $selectedTab.name.onUpdate { oldValue, newValue in
                //handle tabIcon navigation functionality
               
                if oldValue == newValue {
                    
                  
                    if newValue == .home {
                        if router.homePath.count == 0  {
                           
                                shouldScrollToTop_home = true
                        } else {
                            router.homePath.removeLast(router.homePath.count)
                        }
                    
                    } else if
                        newValue == .discover {
                        if router.discoverPath.count == 0 {
                           
                                shouldScrollToTop_discover = true
                            
                            
                        } else {
                            router.discoverPath.removeLast(router.discoverPath.count)

                        }
                    }
                    else if
                        newValue == .user {
                        if router.userPath.count == 0 {
                            shouldScrollToTop_user = true
                            
                        } else {
                            router.userPath.removeLast(router.userPath.count)

                        }
                    }
                    
                   
                }
                
            }) {
                Group {
                    
                    //HomeView
                    NavigationStack(path: $router.homePath) {
                        HomeScreen(shouldScrollToTop: $shouldScrollToTop_home)
                          
                       }
                        .tabItem {
                            Image(systemName: "house")
                               
                        }
                        .tag(Navigation.home)
                        .onAppear {
                            selectedTab.name = .home
                        }
                      
                        
                    
                    
                    //DiscoverView
                    NavigationStack(path: $router.discoverPath) {
                        DiscoverView(shouldScrollToTop: $shouldScrollToTop_discover)
                        }
                        .tabItem {
                            Image(systemName: "magnifyingglass")

                        }
                        .tag(Navigation.discover)
                        .onAppear {
                            selectedTab.name = .discover
                        }
                    
                    
                    //UserView
                    NavigationStack(path: $router.userPath) {
                        ProfileView()
                           
                    }
                    .tabItem { Image(systemName: "person.fill") }
                    .tag(Navigation.user)
                    .onAppear {
                        selectedTab.name = .user
                    }
                    }
                .toolbarBackground(.black, for: .tabBar)
                }
                    .environmentObject(selectedTab)
                    .preferredColorScheme(.dark)
                    .tint(.white)
        }
        }

    

}

#Preview {
    ContentView()
//        .preferredColorScheme(.dark)
}
