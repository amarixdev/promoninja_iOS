//
//  DiscoverView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/27/23.
//

import SwiftUI
import PromoninjaSchema

struct DiscoverView: View {
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
             
              ScrollView  {
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
                                                            .font(.headline.bold())
                                                        
                                                        Text("By tapping below, you confirm you are at least 21")
                                                            .font(.caption)
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
                                        
                                           
                                        }
                                        
                                        Spacer()
                                       
                                    }
                                    .padding(.vertical)                 
                             
                            }
                             
                        }
                        
                        Spacer()
                    }
                   
                    .padding()
                }
             
              .padding(.vertical)
             
            }

            .navigationTitle("Discover")
            .toolbarStyle()
        
         
   
        
      
    }
    
}

#Preview {
    DiscoverView()
        .preferredColorScheme(.dark)
}
