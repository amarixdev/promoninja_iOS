//
//  HomeScreen.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import SwiftUI
import PromoninjaSchema

struct HomeScreen: View {
    @StateObject var viewModel = PodcastCategoryViewModel()
    @StateObject var sponsorVM = SponsorViewModel(name: "", homePage: true)
    
    var categories: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?] {
        viewModel.categoryData?.filter {$0?.name != "news & politics"} ?? []
    }
        
    @State private var searchText = ""
    @State private var podcastData:[GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?] = []
    
    @State private var creatorData: GetPodcastQuery.Data.GetPodcast?
    @State private var selectedCreator = Creator(fullName: "", image: .logo, podcasts: [], summary: "")
    @State private var showSelection = false
    
    var creators: [Creator] {
        getCreators(category: viewModel.currentCategory ?? "")
    }

    
    var dataLoaded: Bool {
        if ( !viewModel.podcasts.isEmpty && !sponsorVM.trendingSponsors[0].isEmpty ) {
            return true
        } else {
            return false
        }
    }
    
    @State private var longPressed = false
    
    struct TrendingSponsor {
        let title: String
        let sponsors: GetSponsorQuery.Data.GetSponsor?
    }
    
    
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                if !dataLoaded  {
                    Image(.logo)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                    
                    LoadingAnimation()
                    
                } else
               
              {
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
                      
                      //Trending Creators
                      VStack {
                          
                          if !viewModel.podcasts.isEmpty {
                              ScrollView(.horizontal) {
                                  LazyHStack(spacing: 15) {
                                      ForEach(viewModel.podcasts, id: \.self) { podcast in
                                          VStack(alignment:.leading)  {
                                              
                                              NavigationLink(value: podcast) {
                                                  AsyncImage(url: URL(string: podcast?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
                                                      
                                                      if let image = phase.image {
                                                          image
                                                              .resizable()
                                                              .scaledToFit()
                                                              .frame(width: 150, height: 150)
                                                              .cornerRadius(10)
//
                                                              
                                                      } else {
                                                          
                                                          Placeholder(frameSize: 150, imgSize: 50, icon: .podcast)
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
                                  Text("Popular Creators")
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
                                                      .fontWeight(.semibold)
                                                      .foregroundStyle(.white)
                                               
                                              }
                                        
                                          .onTapGesture {
                                              selectedCreator = creator
                                              getPodcastData(title: GraphQLNullable(stringLiteral: creator.podcasts[0]))
                                              showSelection = true
                                              
                                          }
                                          .sheet(isPresented: $showSelection) {
                                              ZStack {
                                                  LinearGradient(colors: [Color(.sponsorTheme).opacity(0.85), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom)
                                                      .ignoresSafeArea(.all)
                                                  
                                                  PodcastSelectionSheet(creator: $selectedCreator )
                                                      .presentationDetents([.medium, .large])
                                                
                                              }
                                              
                                          }
                                   
                                      }
                                  }
                         
                              }
                              .scrollIndicators(.hidden)
                              
            
                              
                          } else {
    //                          ProgressView()
                          }
                          
                      }
                      Divider ()
                          .padding()
                      
                      ZStack {
                          
                          HStack {
                              Text("Promoninja curates exclusive deals across hundreds of podcasts, just for you.")
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
                      .shadow(radius: 20)
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
                                                          AsyncImage(url: URL(string: sponsor.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
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

                      Divider()
                    
                
                    
                      
                      NavigationLink(value: Navigation.discoverPage) {
                          HStack {
                              Text("Discover More Deals")
                                  .font(.title2)
                                  .fontWeight(.semibold)
                              Image(systemName: "arrow.right")
                                  .imageScale(.large)
                              
                          }
                          .foregroundStyle(.white)
                          .padding(20)
          
                      }
                      
                    }
                      .padding(.vertical)
//                      .transition(.opacity)
                      
              }
              
                }
            
            .navigationDestination(for: Navigation.self , destination: { _ in
                DiscoverView()
            })
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

    func getPodcastData (title: GraphQLNullable<String>) {
        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
            guard let data = try? result.get().data else { return }
           
            if let fetchedData = data.getPodcast {
                DispatchQueue.main.async {
                    creatorData.self = fetchedData
                }
            }
        }
    }

      
    }


#Preview {
    HomeScreen()
        .preferredColorScheme(.dark)
}
