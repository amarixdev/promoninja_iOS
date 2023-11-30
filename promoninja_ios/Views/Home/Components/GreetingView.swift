//
//  GreetingView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text(greetingMessage())
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Let's find some deals!")
                .font(.title2)
                .fontWeight(.semibold)
                .opacity(0.8)
        }
       
    }

    private func greetingMessage() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)

        if hour < 12 {
            return "Good Morning,"
        } else if hour < 18 {
            return "Good Afternoon,"
        } else {
            return "Good Evening,"
        }
    }
}

#Preview {
    GreetingView()
        .preferredColorScheme(.dark)
}
