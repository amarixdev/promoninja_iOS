//
//  PodcastCategory.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/11/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct PodcastCategory: View {
    let category: GetPodcastCategoriesQuery.Data.GetPodcastCategory
    let podcasts = [ "One", "Two", "Three"]
    var body: some View {
        ZStack {
            Color.appTheme
                .ignoresSafeArea()
            ScrollView {
                ForEach(category.podcast ?? [], id:\.self) { podcast in
                    if let podcast = podcast {
                     
                        NavigationLink(value: podcast){
                            HStack(spacing: 15) {
                                    LazyImage(url: URL(string: podcast.imageUrl ?? "")) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                        }
                                    }
                                    VStack(alignment:.leading) {
                                        Text(podcast.title )
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(podcast.publisher ?? "")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                            .opacity(0.8)
                                        
                                        HStack(spacing: 5) {
                                            Text("Offers:")
                                                .font(.caption)
                                            Text(String (podcast.sponsors?.count ?? 0))
                                                .font(.caption.bold())
                                        }
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 8)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(10)
//                                        .shadow( radius: 3, x: 2, y: 5)
                                    }
                                    Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                                    .opacity(0.4)
                                }
                        }
                        .padding()
                        
                        Divider()
                        
                      
                    }
                
                }
            }
        }
     
        .navigationTitle(category.name?.capitalized ?? "")
        .toolbarStyle()
    }
}

//#Preview {
//    PodcastCategory()
//}
