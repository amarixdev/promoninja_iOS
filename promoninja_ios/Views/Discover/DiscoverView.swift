//
//  DiscoverView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct DiscoverView: View {
    
    private static let topId = "topIdHere"
    @Binding var shouldScrollToTop: Bool
    
    @StateObject var viewModel = SponsorCategoryViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    
    var categories: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?] {
        viewModel.categoryData ?? []
    }
    
    @State private var searchText = ""
    @State private var userIsLegal = false
    
    
    var body: some View {
        
       
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                if categories.isEmpty {
                    LoadingAnimation()
                } else {
                    ScrollViewReader { reader in
                         ScrollView  {
                             GeometryReader { geo in
                                 Rectangle()
                                   .frame(width: 0, height: 0)
                                   .onChange(of: geo.frame(in: .global).midY) {
                                       shouldScrollToTop = false
                               }
                             }
                               VStack {
                                  
                                   //category fields
                                   ForEach(categories.prefix(userIsLegal ? 8 : 7), id: \.self) { category in
                                       if let category = category {
                                               HStack {
                                                   VStack(alignment: .leading, spacing: 20) {
                                                       HStack {
                                                           Text(category.name == "Outdoors" ? "Misc." : category.name)
                                                               .font(.title3)
                                                               .fontWeight(.semibold)
                                                               .blur(radius: !userIsLegal && (category.name == "Alcohol" || category.name == "Smoke & Vape") ? 10 : 0 )
                                                           Spacer()
                                                           
                   
                                                           //Temp hard-code for limited sponsors
                                                           if category.name != "Outdoors" && category.name != "Alcohol" {
                                                               
                                                               if !userIsLegal && category.name == "Smoke & Vape" {
                                                                   HStack {
                                                                           Text("View all")
                                                                           .fontWeight(.semibold)
                                                                           Image(systemName: "arrow.right")
                                                                   }
                                                                   .foregroundStyle(.white)
                                                                   .font(.caption)
                                                                   .blur(radius: 10)
                                                               } else {
                                                                   NavigationLink(value: category ){
                                                                       HStack {
                                                                               Text("View all")
                                                                               Image(systemName: "arrow.right")
                                                                       }
                                                                       .foregroundStyle(.white)
                                                                       .font(.caption)
                                                                 
                                                                   }
                                                               }
                                                             
                                                
                                                           }
                                                              
                                                          
                                                              
                                                       }
                                                       
                                                       if !userIsLegal && ( category.name == "Alcohol" || category.name == "Smoke & Vape") {
                                                           ZStack {
                                                             
                                                               Color.black
                                                                   .contentShape(Rectangle())
                                                                   .frame(height: 150)
                                                                   .blur(radius: 10)
                                                                   .cornerRadius(10)
                                                               VStack {
                                                                   Text("Are you 21 or older?")
                                                                       .font(.title2.bold())
                                                                   
                                                                   Text("By tapping below, you confirm you are at least 21")
                                                                       .multilineTextAlignment(.center)
                                                                       .font(.subheadline)
                                                                       .opacity(0.8)
                                                                   
                                                                   Button("I'm over 21") {
                                                                       withAnimation {
                                                                           userIsLegal = true
                                                                       }
                                                                       
                                                                     
                                                                   }
                                                                   .buttonStyle(.bordered)
                                                                   .padding()
                                                       
                                                               }
                                                  
                                                              
                                                           }
                                                         
                                                               
                                                       } else

                                                       {
                                                           ScrollView(.horizontal) {
                                                               HStack(spacing: 20) {
                                                                   if let sponsors = category.sponsor {
                                                                      
                                                                       ForEach(sponsors.prefix(5), id: \.self) { sponsor in
                                                                           
                                                                           ZStack {
                                                                            
                                                                               if let imageUrl = sponsor?.imageUrl {
                                                                                   NavigationLink(value: sponsor ) {
                                                                                       
                                                                                       LazyImage(url: URL (string: imageUrl)!, transaction: Transaction(animation: .bouncy)) { phase in
                                                                                           if let image = phase.image {
                                                                                               image.resizable()
                                                                                                   .scaledToFill()
                                                                                                   .frame(width: 100, height: 100)
                                                                                                   .cornerRadius(10)
                                                                                              
                                                                                           }
                                                                                                        
                                                                                           else {
                                                                                               Placeholder(frameSize: 100, imgSize: 40, icon: .sponsor)
                                                                                           }
                                                                                       }
                                                                                   }
                                                                               }
                                                                                      
                                                    
                                                                               }
                                                                      
                                                                           }
                                                                       
                                                                       if sponsors.count >= 5 {
                                                                           NavigationLink(value: category) {
                                                                               Image(systemName: "arrow.right")
                                                                                   .imageScale(.large)
                                                                                   .padding(.horizontal, 20)
                                                                                   .foregroundStyle(.white)
                                                                                   
                                                                               
                                                                           }
                                                               
                                                                          
                                                                       }
                                                                        
                                                                      
                                                                   }
                                                                
                                                               }
                                                               .padding(.bottom)
                                                           }
                                                       }
                                                   
                                                      
                                                   }
                                                   
                                                   Spacer()
                                                  
                                               }
                                               .padding(.vertical)
                                        
                                       }
                                        
                                   }
                                   
                                   Spacer()
                               }
                               .id(Self.topId)
                            
                              
                               .padding(.horizontal)
                           }
                         .onChange(of: shouldScrollToTop) {
                                            withAnimation {
                                                reader.scrollTo(Self.topId, anchor: .top)
                                            }
                                        }
                     }
                }
           
                          
            }
           .sensoryFeedback(.selection, trigger: userIsLegal)
           .navigationTitle("Discover")
        
           .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.self) { category in
               CategoryView(category: category)
           
           }
       
           .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast.self) { podcast in
               PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
           }
           
           
           .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.Podcast.self) { podcast in
                       PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
                   }
       
           .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.self) { podcast in
               PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
                   }
           
           .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor.self) { sponsor in
               if let name = sponsor.name {
                   SponsorView(name: name )
               }
           }
        
           .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.Sponsor.self) { sponsor in
               if let name = sponsor.name {
                   SponsorView(name: name)
               }
                      
                   }
       
           .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.self) { sponsor in
               if let name = sponsor.name {
                   SponsorView(name: name)
               }
                      
                   }
     
    }
    
}

#Preview {
    NavigationStack {
        DiscoverView(shouldScrollToTop: .constant(false))
            .preferredColorScheme(.dark)
    }
  
}
