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
    @Published var path = NavigationPath() {  
        didSet {
            print("navigationModel.path.count: \(path.count)")
            print (Router.router.path.isEmpty)
        }
    }

}

enum Navigation: String, Hashable {
    case discoverPage
}
