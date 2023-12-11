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
    
    
    let sponsorVM: SponsorViewModel
    var body: some View {
        ZStack {
            
            HStack {
                Text("\"Promoninja curates exclusive deals across hundreds of podcasts, just for you.\"")
                    .opacity(0.8)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(20)
            }
           
                
        }
        .background(.ultraThinMaterial)
        .opacity(0.95)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.top, 30)
        .padding(.bottom, 20)
        
        VStack {
          ForEach(0 ..< sponsorVM.trendingSponsors.count, id: \.self) { index in
              VStack {
                  HStack {
                      Text(sponsorGroups[index].title)
                          .font(.title3)
                          .fontWeight(.semibold)
                      Spacer()
                  }
              
                  ScrollView(.horizontal) {
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
                                                      .frame(width: 150, height: 150)
                                                      .cornerRadius(10)
                                                      
                                              } else {
                                                  Placeholder(frameSize: 150, imgSize: 50, icon: .sponsor)
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
                      .padding(.bottom)
                          
                      }
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
