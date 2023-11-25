//
//  SponsorList.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema

struct SponsorListView: View {
    
    let podcast: GetPodcastQuery.Data.GetPodcast?
    
    var body: some View {
        VStack(spacing: 10) {
                ForEach(podcast?.sponsors ?? [], id:\.self) {
                    sponsor in
                    
                    NavigationLink(value: sponsor)  {
                        
                     
                            HStack(spacing: 30) {
                                if let index = podcast?.sponsors?.firstIndex(of: sponsor) {
                                    Text(String (index))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                AsyncImage(url: URL(string: sponsor?.imageUrl ?? "")) {
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
                                    if let name = sponsor?.name {
                                        Text(name.truncated(maxLength: 30) )
                                            .font(.caption.bold())
                                            .foregroundStyle(.white)
                                    }
                                    if let url = sponsor?.url {
                                        Text(url.truncated(maxLength: 30))
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

//#Preview {
//    SponsorListView(po)
//}
