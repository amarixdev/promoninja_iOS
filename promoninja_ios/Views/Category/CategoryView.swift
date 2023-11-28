//
//  CategoryView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import SwiftUI
import PromoninjaSchema

struct CategoryView: View {
    let category: GetSponsorCategoriesQuery.Data.GetSponsorCategory
    
//    var randomizedSponsors: [GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor?]? {
//        category.sponsor?.shuffled()
//    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 10)
                 {
                     if let sponsors = category.sponsor {
                        ForEach(sponsors, id:\.self) { sponsor in
                            if let sponsor = sponsor {
                                
                                NavigationLink(value:sponsor){
                                    HStack(spacing: 25) {
                                        if let imageUrl = sponsor.imageUrl {
                                            AsyncImage(url: URL(string: imageUrl)) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 70, height: 70)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 10)
                                                }
                                                else {
                                                    ZStack {
                                                        ProgressView()
                                                            .progressViewStyle(.circular)
                                                        Rectangle()
                                                            .foregroundStyle(.white.opacity(0.2))
                                                        
                                                    }
                                                    .frame(width: 70, height: 70)
                                                    .cornerRadius(10)
                                                }
                                                
                                            }
                                        }
                                        VStack(alignment:.leading) {
                                            Text(sponsor.name!)
                                                .font(.title2)
                                                .multilineTextAlignment(.leading)
                                                .foregroundStyle(.white)
                                                .fontWeight(.semibold)
                                            Text(sponsor.offer!)
                                                .font(.caption)
                                                .multilineTextAlignment(.leading)
                                                .foregroundStyle(.white)
                                                .opacity(0.8)
                                               
                                            
                                        }
                                            Spacer()
                                                Image(systemName: "chevron.right")
                                                        .foregroundStyle(.white.opacity(0.5))
                                       
                                    }
                                }
                                .padding()
                                Divider()
                            }
                        }
                    }
                   
                }
            }
            .padding(.top, 50)
        }
      
        .navigationTitle(category.name)
        .toolbarTitleDisplayMode(.inline)
    }
}


