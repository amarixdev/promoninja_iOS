//
//  ExpandableView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/27/23.
//

import SwiftUI

struct ExpandedView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
            
        }
    
    }
}

struct ThumbnailView: View, Identifiable {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}


struct ExpandableView: View {
    @Namespace private var namespace
       @State private var show = false
       
       var thumbnail: ThumbnailView
       var expanded: ExpandedView
       
       var thumbnailViewBackgroundColor: Color = .sponsorTheme.opacity(0.05)
    var expandedViewBackgroundColor: Color = .logo
       
       var thumbnailViewCornerRadius: CGFloat = 10
       var expandedViewCornerRadius: CGFloat = 10
       
    var body: some View {
           ZStack {
               if !show {
                   thumbnailView()
               } else {
                   expandedView()
               }
           }
           .shadow(color: .black, radius: 4)
           .onTapGesture {
            
                   withAnimation (.spring(response: 0.6, dampingFraction: 0.8)){
                       show.toggle()
                   }
               
           }
       }
    
    @ViewBuilder
        private func thumbnailView() -> some View {
            ZStack {
                thumbnail
                    .matchedGeometryEffect(id: "view", in: namespace)
            }
           
            
            .background(
                thumbnailViewBackgroundColor.matchedGeometryEffect(id: "background", in: namespace)
            )
            .padding(.horizontal)
            .mask(alignment: .center, {
                RoundedRectangle(cornerRadius: thumbnailViewCornerRadius, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            }
            
            )
            
        }
    
    
    @ViewBuilder
       private func expandedView() -> some View {

           ZStack {
               expanded
                   .matchedGeometryEffect(id: "view", in: namespace)
               .background(
                   expandedViewBackgroundColor
                       .matchedGeometryEffect(id: "background", in: namespace)
               )
               .shadow(color:.black, radius: 4)
               .mask( alignment: .center, {
                   RoundedRectangle(cornerRadius: expandedViewCornerRadius, style: .continuous)
                       .matchedGeometryEffect(id: "mask", in: namespace)
               }
               )

           }
           .padding()
           
       }
    
    
}

//#Preview {
//    ExpandableView(thumbnail: ThumbnailView, expanded: <#T##ExpandedView#>)
//}
