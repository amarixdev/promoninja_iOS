//
//  NetworkManager.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/12/24.
//

import Network
import SwiftUI

class NetworkManager: ObservableObject {
    let monitor: NWPathMonitor
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected: Bool = true

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}



