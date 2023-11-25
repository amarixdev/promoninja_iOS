//
//  Router.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/24/23.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func home ()  {
        path = NavigationPath()
    }
}
