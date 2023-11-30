//
//  CreatorsView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import SwiftUI
import PromoninjaSchema

struct CreatorsView: View {
    @StateObject var viewModel = PodcastCategoryViewModel()

    
    var categories: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?] {
        viewModel.categoryData?.filter {$0?.name != "news & politics"} ?? []
    }
    
    @State private var searchText = ""
    @State private var podcastData:[GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?] = []
    
    @State private var creatorData: GetPodcastQuery.Data.GetPodcast?
    @State private var selectedCreator = Creator(fullName: "", image: .logo, podcasts: [])
    @State private var showSelection = false
    
    var creators: [Creator] {
        getCreators(category: viewModel.currentCategory ?? "")
    }


    func getPodcastData (title: GraphQLNullable<String>, completion: @escaping (_ fetchedData: GetPodcastQuery.Data.GetPodcast? ) -> Void) {
        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
            guard let data = try? result.get().data else { return }
           
            if let fetchedData = data.getPodcast {
                DispatchQueue.main.async {
                    creatorData.self = fetchedData
                    completion(fetchedData)
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
           
          ScrollView  {
              
              VStack {
                  HStack {
                      GreetingView()
                      Spacer()
                  }
                  .padding(20)
                 
                  Spacer()
              }
              
              //Slider
              ScrollView(.horizontal) {
                  HStack {
                      ForEach(categories, id:\.self) { category in
                        
                          if let name = category?.name {
                              Button(name.capitalized ) {
    
                                  viewModel.currentCategory = name
                                  print(viewModel.currentCategory ?? "comedy")
                                 
                              }
                                .fontWeight(.medium)
                                .font(.subheadline)
                                  .buttonStyle(.borderedProminent)
                                  .tint(viewModel.currentCategory == name ? .logo : .sponsorTheme)
                                  .foregroundStyle(viewModel.currentCategory == name ? .white : .white.opacity(0.8))
                          }
                          
                      }
                  }
                  .padding(.horizontal, 10)
                  
              }

              .scrollIndicators(.hidden)
              
              VStack {
                  if !viewModel.podcasts.isEmpty {
//                      Text("Trending Podcasts")
                      ScrollView(.horizontal) {
                          HStack(spacing: 15) {
                              ForEach(viewModel.podcasts.prefix(8), id: \.self) { podcast in
                                  VStack(alignment:.leading)  {
                                      
                                      NavigationLink(value: podcast) {
                                          AsyncImage(url: URL(string: podcast?.imageUrl ?? "")) { phase in
                                              if let image = phase.image {
                                                  image
                                                      .resizable()
                                                      .scaledToFit()
                                                      .frame(width: 150, height: 150)
                                                      .cornerRadius(10)
                                              } else {
                                                  ZStack {
                                                      ProgressView()
                                                          .progressViewStyle(.circular)
                                                      Rectangle()
                                                          .foregroundStyle(.clear)
                                                      
                                                      
                                                  }
                                                  .frame(width: 150, height: 150)
                                                  .cornerRadius(10)
                                              }
                                          }
                                      }
                                          VStack(alignment:.leading, spacing: 3) {
                                              Text(podcast?.title.truncated(16) ?? "")
                                                  .font(.caption)
                                                  .fontWeight(.semibold)
                                              Text(podcast?.publisher?.truncated(16) ?? "")
                                                  .font(.caption)
                                                  .opacity(0.8)
                                          }
                                          .padding(.leading, 5)
                                          .padding(.top, 5)
                                      }
                                 
                                
                             
                              }
                      }
                          .padding(.vertical, 20)
                          
                      }
                      
                      HStack {
                          Text("Trending Creators")
                              .font(.headline)
                          Spacer()
                      }
                      .padding()
                     
                      ScrollView(.horizontal) {
                          HStack(spacing: 20) {
                              ForEach(creators, id: \.self) { creator in
                                  
                                 
                                      VStack {
                                          Image(creator.image)
                                              .resizable()
                                              .scaledToFill()
                                              .frame(width: 100, height: 100)
                                              .clipShape(Circle())
                                          Text(creator.fullName)
                                              .font(.caption)
                                              .foregroundStyle(.white)
                                              
                                             
                                      }
                                
                                  .onTapGesture {
                                      selectedCreator = creator
                                      getPodcastData(title: GraphQLNullable(stringLiteral: creator.podcasts[0])) {
                                          fetchedData in
                                          
                                          if creator.multiplePodcasts {
                                            showSelection = true
                                            
                                          } else {
                                              if let fetchedData = fetchedData {
                                                  Router.router.path.append(fetchedData)
                                                  
                                              }
                                          }
                                      }
                                      
                                  }
                                  .sheet(isPresented: $showSelection) {
                                      //Bug: only passing 1st creator in array
                                      PodcastSelectionSheet(creator: $selectedCreator )
                                          .presentationDetents([.medium])
                                  }
                           
                              }
                          }
                 
                      }
                      .scrollIndicators(.hidden)
                      
    
                      
                  } else {
                      ProgressView()
                  }
                  
              }
              
             //Trending Podcasts
               
            }
        }

        
      
    }
}

#Preview {
    CreatorsView()
        .preferredColorScheme(.dark)
}
