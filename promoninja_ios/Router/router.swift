//
//  router.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    static var router = Router()
        
    @Published var homePath = NavigationPath()
    
    @Published var discoverPath = NavigationPath()
    
    
    @Published var searchPath = NavigationPath() 
}

class CurrentTab: ObservableObject {
    @Published var name: Navigation = .home
}



enum Navigation: String {
    case home
    case discover
    case search
    case qtna
}
