//
//  promoninja_iosApp.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import SwiftUI
import Apollo
import SwiftData

@main
struct promoninja_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [SavedOffer.self, FavoritePodcast.self])
                .environment(\.colorScheme, .dark)
                .environmentObject(GlobalState())
        }
    }
}
