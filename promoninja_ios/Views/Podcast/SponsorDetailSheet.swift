//
//  SponsorDetailSheet.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema





struct SponsorDetailSheet: View {
    let podcast: GetPodcastQuery.Data.GetPodcast?
   @Binding var sponsor: GetPodcastQuery.Data.GetPodcast.Sponsor?
   @StateObject var router = Router.router
   @Environment(\.dismiss) var dismiss
       
    @State private var copied = false
    @State private var degrees:Double = 0

    
    var matchingOffer: GetPodcastQuery.Data.GetPodcast.Offer? {
         guard let podcast = podcast,
               let offers = podcast.offer
          else { return nil }
          
        let matchingOffer = offers.filter {$0?.sponsor == sponsor?.name}
         return matchingOffer[0]
      }
      
      
      var affiliateLink: String {
          return matchingOffer?.url ?? ""
      }
      
      var promoCode: String {
          return matchingOffer?.promoCode ?? ""
      }
  
    

 
    
    var body: some View {
                VStack {
                    //header
                    HStack(spacing: 15) {
                        if let imageUrl = sponsor?.imageUrl {
                      
                                AsyncImage(url: URL (string: imageUrl)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                    } else {
                                        ZStack {
                                          ProgressView()
                                                .progressViewStyle(.circular)
                                        }
                                        .frame(width: 100, height: 100)
                                    }
                                   
                                }
                                .rotation3DEffect(
                                    .degrees(degrees),
                                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .onTapGesture {
                                    
                                    if let sponsor = sponsor {
                                        router.path.append(sponsor)
                                    }
                                    
                                        dismiss()
                                    }
                                    
                        
                        }
                 
                        VStack(alignment:.leading) {
                            Text(sponsor?.name ?? "")
                                .font(.title3.bold())
                            Text(sponsor?.url ?? "")
                                .font(.subheadline)
                                .opacity(0.8)
                     
                            
                        }
                      
                        Spacer()
                       
                    }
                    .padding(.vertical)
                   
                    
                    VStack(spacing: 40) {
                        VStack(spacing: 15) {
                            Text("Exclusive Offer:")
                                .font(.title3.bold())
                            Text(sponsor?.offer ?? "")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .opacity(0.8)
                                .padding(.horizontal, 20)
                               
                        }
                      
                        
                        VStack {
                            Text("Affiliate Link")
                                .fontWeight(.semibold)
                                .font(.caption)
                            
                            Link(destination: URL(string: "https://"+affiliateLink)!, label: {
                                Text(affiliateLink)
                                    .font(.subheadline)
                                    .opacity(0.8)
                            })
                            .padding(10)
                            .background()
                            .cornerRadius(10)
                        }
                       
                        Divider()
                        
                    }
                    
                   //promoCode Button
                  
                   Spacer()
                    if !promoCode.isEmpty {
                        VStack(spacing: 10) {
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
                                    ZStack {
                                        Text(promoCode)
                                            .font(.title2)
                                            .fontWeight(.heavy)
                                            .tracking(5)
                                            .opacity(copied ? 0 : 1)
                                        Text("Copied")
                                            .font(.title2)
                                            .fontWeight(.heavy)
                                            .tracking(5)
                                            .opacity(copied ? 1 : 0)
                                    }
                                    .animation(.none, value: copied)
                                    Image(systemName: "doc.on.doc")
                                        .imageScale(.small)
                                }
                               
                               
                            }
                        }
                    }
             
                    
                    Spacer()
                }
                .sensoryFeedback(.success, trigger: copied)

              
            
            .padding()
   
   
    }
    
}

//#Preview {
//    SponsorDetailSheet()
//}
