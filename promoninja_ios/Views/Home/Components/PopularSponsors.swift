//
//  TrendingSponsors.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/6/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct PopularSponsors: View {
    
    struct TrendingSponsor {
        let title: String
        let sponsors: GetSponsorQuery.Data.GetSponsor?
    }
    
    var lastUpdated = Date.now
    
    let sponsorVM: SponsorViewModel
    var body: some View {
        
        HStack {
            Text("Trending Offers")
                .font(.title.bold())
                .opacity(0.8)
            Spacer()
        }
        .padding(.leading)


        
        VStack(alignment:.leading) {
            Text( "Last updated: " + String(lastUpdated.formatted(.dateTime.month().year()).description))
                .italic()
                .foregroundStyle(.secondary)
                .padding(.leading)
            
          ForEach(0 ..< sponsorVM.trendingSponsors.count, id: \.self) { index in
              VStack {
                  HStack {
                      Text(sponsorGroups[index].title)
                          .font(.title3)
                          .fontWeight(.semibold)
                      Spacer()
                  }
              
    
                      HStack(spacing: 15) {
                          
                          ForEach(sponsorVM.trendingSponsors[index], id:\.self) { sponsor in
                              if let sponsor = sponsor {
                      
                                  NavigationLink(value: sponsor) {
                                      VStack(alignment: .leading) {
                                          LazyImage(url: URL(string: sponsor.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)) { phase in
                                              if let image = phase.image {
                                                  image
                                                      .resizable()
                                                      .scaledToFit()
                                                      .frame(width: 115, height: 115)
                                                      .cornerRadius(10)
                                                      .shadow(color:.black, radius: 4, x: 5, y: 4)

                                                      
                                              } else {
                                                  Placeholder(frameSize: 115, imgSize: 50, icon: .sponsor)
                                              }
                                              
                                           
                                              
                                              
                                          }
                                          
                                          Text(sponsor.name?.truncated(16) ?? "")
                                                  .font(.caption)
                                                  .opacity(0.8)
                                              .foregroundStyle(.white)
                                      }
                                  }
                              }
                              
                          }
                              
                          }
                      .frame(maxWidth:.infinity, alignment:.center)
                      .padding(.bottom)
                          
                      
                  }
                  
              }
              
                      
                      .padding()
                  }
    }
}

#Preview {
    PopularSponsors(sponsorVM: SponsorViewModel(name: "", homePage: true))
        .preferredColorScheme(.dark)
}
