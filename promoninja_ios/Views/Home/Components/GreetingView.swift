//
//  GreetingView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        Text(greetingMessage())
            .font(.largeTitle)
            .fontWeight(.bold)
            .opacity(0.9)
    }

    private func greetingMessage() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)

        if hour < 12 {
            return "Good Morning"
        } else if hour < 18 {
            return "Good Afternoon"
        } else {
            return "Good Night"
        }
    }
}

#Preview {
    GreetingView()
}
