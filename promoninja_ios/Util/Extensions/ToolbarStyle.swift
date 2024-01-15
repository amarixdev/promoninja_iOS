//
//  ToolbarStyle.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/4/23.
//

import SwiftUI

struct ToolBar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let inline: Bool
    
    func body(content: Content) -> some View {
        content
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(.white)
        .toolbarTitleDisplayMode(inline ? .inline : .large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                   Spacer()
                }
   
                .frame(width: 50, height: 50)
                .onTapGesture {
                    dismiss()
                }
             
   
            }
        }
    
    }
}


extension View {
    func toolbarStyle (inline: Bool) -> some View {
        
        modifier(ToolBar(inline: inline))
    }
}
