//
//  PromoCode.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/6/24.
//

import SwiftUI

struct PromoCode: View {
    let promoCode: String
    @Binding var copied: Bool
    @Binding var degrees:Double
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            Text("Use code at checkout")
                .font(.subheadline)
                .opacity(0.8)
            Button {
                let pasteboard = UIPasteboard.general
                pasteboard.string = promoCode
                copied = true
                withAnimation {
                    degrees += 360
                }
              
            } label: {
                HStack {
                    ZStack(alignment:.leading) {
                        HStack {
                            Text(promoCode.uppercased())
                                .font(.title2)
                                .fontWeight(.heavy)
                                .tracking(5)
                            Image(systemName: "doc.on.doc")
                                .imageScale(.small)
                        }
                        .opacity(copied ? 0 : 1)
                        
                        HStack {
                            Text("Copied")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .tracking(5)
                            Image(systemName: "doc.on.doc")
                                .imageScale(.small)
                        }
                        .opacity(copied ? 1 : 0)
                    }
                    .animation(.none, value: copied)
                   
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    PromoCode(promoCode: "SQUARESPACE", copied: <#T##_#>,  degrees: .constant(360))
//        .preferredColorScheme(.dark)
//}
