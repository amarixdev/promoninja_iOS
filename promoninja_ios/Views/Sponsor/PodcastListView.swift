//
//  PodcastListView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema

struct PodcastListView: View {
    
    let sponsor: GetSponsorQuery.Data.GetSponsor?
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(sponsor?.podcast ?? [], id: \.self) {
                podcast in
             
                NavigationLink(value: podcast) {
                            HStack(spacing: 30) {
                                if let index = sponsor?.podcast?.firstIndex(of: podcast) {
                                    Text(String (index))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                AsyncImage(url: URL(string: podcast?.imageUrl ?? "")) {
                                    phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(10)
                                    } else {
                                        Rectangle()
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(10)
                                            .foregroundStyle(Color(.systemGray5).gradient)
                                    }
                                }
                                
                                VStack(alignment:.leading) {
                                    if let podcast = podcast {
                                        Text(podcast.title.truncated(maxLength: 20))
                                            .font(.caption.bold())
                                            .foregroundStyle(.white)
                                        
                                        Text(podcast.publisher?.truncated(maxLength: 20) ?? "")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                  
                                Spacer()
                            }
                            
                        }

                        Divider()
                    
                     
                }
            }
            .padding()
    }
}

//
//#Preview {
//    PodcastListView()
//}
