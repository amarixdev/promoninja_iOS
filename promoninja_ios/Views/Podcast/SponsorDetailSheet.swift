//
//  SponsorDetailSheet.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema

struct SponsorDetailSheet: View {
   @Binding var sponsor: GetPodcastQuery.Data.GetPodcast.Sponsor?
   @StateObject var router = Router.router
   @Environment(\.dismiss) var dismiss
    
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
                                    }
                                   
                                }
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
                            Button {
                             
                            } label: {
                                Text(sponsor?.url ?? "")
                                    
                            }
                            .buttonStyle(.bordered)
                            .opacity(0.8)
                        }
                       
                        Divider()
                        
                    }
                    
                   //promoCode Button
                  
                   Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                    
                    Spacer()
                }
              
            
            .padding()
   
   
    }
    
}

//#Preview {
//    SponsorDetailSheet()
//}
