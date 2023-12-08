//
//  TestView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/3/23.
//

import SwiftUI

struct TestView: View {
    let pickerValues = [1,2]
    @State private var selected = 0
    @State private var searchText = ""
    var body: some View {
        VStack {
            Picker(selection: $selected, content: {
                ForEach(pickerValues, id:\.self) {
                    Text(String ($0))
                }
            }, label: {
                Text("Picker")
            })
                .pickerStyle(.segmented)
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    TestView()
}
