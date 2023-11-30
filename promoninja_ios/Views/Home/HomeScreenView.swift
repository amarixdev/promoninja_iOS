//
//  HomeScreenView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI
import PromoninjaSchema

struct HomeScreenView: View {
    @StateObject var viewModel = SponsorCategoryViewModel()
    
    
    var categories: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?] {
        viewModel.categoryData ?? []
    }
    
    @State private var searchText = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                     Text("Discover")
                            .font(.title)
                            .fontWeight(.heavy)
//                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .padding(.leading)
                            
                        Spacer()
                        Image(.logo)
                             .resizable()
                             .scaledToFit()
                             .frame(width: 50, height: 50)
               
                    
                   
                    .padding()
                  
                }
 
                Spacer()
            }
         
            .zIndex(10)
       
           
            
          ScrollView  {
                VStack {
                   
                    //category fields
                    ForEach(categories, id: \.self) { category in
                        if let category = category {
                                HStack {
                                    VStack(alignment: .leading, spacing: 20) {
                                        HStack {
                                            Text(category.name == "Outdoors" ? "Misc." : category.name)
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                            Spacer()
                                            
                                            
                                            //Temp hard-code for limited sponsors
                                            if category.name != "Outdoors" && category.name != "Alcohol" {
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
                                       
                                       
                                        ScrollView(.horizontal) {
                                            HStack(spacing: 20) {
                                                if let sponsors = category.sponsor {
                                                    
                                                    ForEach(sponsors.prefix(5), id: \.self) { sponsor in
                                                      
                                                               if let imageUrl = sponsor?.imageUrl {
                                                               
                                                                   NavigationLink(value: sponsor ) {
                                                                       AsyncImage(url: URL (string: imageUrl)) { phase in
                                                                           if let image = phase.image {
                                                                               image.resizable()
                                                                                   .scaledToFill()
                                                                                   .frame(width: 100, height: 100)
                                                                                   .cornerRadius(10)
                                                                           } 
                                                                                        
                                                                           else {
                                                                               ZStack {
                                                                                   ProgressView()
                                                                                       .progressViewStyle(.circular)
                                                                                   Rectangle()
                                                                                       .foregroundStyle(.white.opacity(0.2))
                                                                                       
                                                                                       
                                                                               }
                                                                               .frame(width: 100, height: 100)
                                                                               .cornerRadius(20)
                                                                           }
                                                                       }
                                                                   }
                                                               }
                                                              
                                      
                                                          
                                                        
                                                      
                                                    }
                                                    if sponsors.count >= 5 {
                                                        NavigationLink(value: category) {
                                                            Image(systemName: "arrow.right")
                                                                .imageScale(.large)
                                                                .padding(.leading)
                                                                .foregroundStyle(.white)
                                                        }
                                                       
                                                    }
                                                   
                                                }
                                             
                                            }
                                        }
                                    
                                       
                                    }
                                    
                                    Spacer()
                                   
                                }
                                .padding(.vertical)
                                
                                
                       
                                .padding(.vertical)
                        
                           
                        }
                         
                    }
                    
                    Spacer()
                }
               
                .padding()
            }
         
          .padding(.top, 100)
         
        }
        .navigationTitle("Discover")
        
      
    }
    
}

#Preview {
    HomeScreenView()
        .preferredColorScheme(.dark)
}
