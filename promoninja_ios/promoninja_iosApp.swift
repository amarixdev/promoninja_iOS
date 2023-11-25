//
//  promoninja_iosApp.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo


@main
struct promoninja_iosApp: App {

    @StateObject var router = Router()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                
        }
    }
}
