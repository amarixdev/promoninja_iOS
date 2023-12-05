//
//  ToolbarStyle.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/4/23.
//

import SwiftUI

struct ToolBar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(.white)
        .toolbarTitleDisplayMode(.inline)

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
    func toolbarStyle () -> some View {
        
        modifier(ToolBar())
    }
}
