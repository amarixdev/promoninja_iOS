//
//  TestView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/3/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationLink {
           DiscoverView()
            
        } label: {
            Text("Next")
        }
    }
}

#Preview {
    TestView()
}
