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
    
    @Published var activePath = NavigationPath()
    @Published var homePath = NavigationPath() {
        didSet {
            activePath = homePath
        }
    }
    
    @Published var discoverPath = NavigationPath() {
        didSet {
            activePath = discoverPath

        }
    }
}

class CurrentTab: ObservableObject {
    @Published var name: String = "home"
}



enum Navigation: String, Hashable {
    case discoverPage
}
