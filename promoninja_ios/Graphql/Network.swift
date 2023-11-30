//
//  apollo-client.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/20/23.
//

import Apollo
import SwiftUI

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://promoninja-apollogql.herokuapp.com")!)
}

//  "https://promoninja-apollogql.herokuapp.com" || "http://localhost:4000/"

