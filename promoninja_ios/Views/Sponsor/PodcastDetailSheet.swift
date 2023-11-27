//
//  PodcastDetailSheet.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema

struct PodcastDetailSheet: View {
   @Binding var podcast: GetSponsorQuery.Data.GetSponsor.Podcast?
    let sponsor: GetSponsorQuery.Data.GetSponsor?
    
   @StateObject var router = Router.router
   @Environment(\.dismiss) var dismiss
    
    var podcastTheme: Color {
        return Color(rgbString: podcast?.backgroundColor ?? "rgb(0,0,0)")
    }
        
    var body: some View {
    
            
          
            VStack {
                //header
                HStack(spacing: 15) {
                    if let imageUrl = podcast?.imageUrl {
                  
                            AsyncImage(url: URL (string: imageUrl)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                }
                               
                            }
                           
                        
                            .onTapGesture {
                                if let podcast = podcast {
                                    router.path.append(podcast)
                                    }
                                
                                    dismiss()
                                }
                                
                    
                    }
             
                    VStack(alignment:.leading) {
                        Text(podcast?.title ?? "")
                            .font(.title3.bold())
                        Text(podcast?.publisher ?? "")
                            .font(.subheadline)
                            .opacity(0.8)
                        
                    }
                  
                    Spacer()
                   
                }
                .padding()
                
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
                            Text( sponsor?.url ?? "")
                                
                        }
                        .buttonStyle(.bordered)
                        .opacity(0.8)
                    }
                   
                    Divider()
                }
                
               //promoCode Button
              
               Spacer()
                
            }
            
                   
            .padding()
          
            
        
    }
}

//#Preview {
//    PodcastDetailSheet()
//}
