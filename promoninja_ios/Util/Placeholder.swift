//
//  SponsorPlaceholder.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/5/23.
//

import SwiftUI

enum SFSymbol {
    case podcast
    case sponsor
    
    var symbol: String {
        switch self {
        case .podcast:
            return "waveform.and.person.filled"
        case .sponsor:
            return "bag"
       
        }
    }
}

struct Placeholder: View {
    let frameSize: CGFloat
    let imgSize: CGFloat
    let icon: SFSymbol
    
    var body: some View {
        ZStack {
            Image(systemName: icon.symbol)
                .resizable()
                .scaledToFit()
                .frame(width: imgSize, height: imgSize)
                .opacity(0.8)
            Color.white.opacity(0.1)
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(10)
        }
    }
}

#Preview {
    
    Placeholder(frameSize: 150, imgSize: 50, icon: .sponsor)
        .preferredColorScheme(.dark)
}
