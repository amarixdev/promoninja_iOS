//
//  HomeScreen.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import SwiftUI
import PromoninjaSchema


struct HomeScreen: View {
    private static let topId = "topIdHere"
    @Binding var shouldScrollToTop: Bool
    @StateObject var viewModel = PodcastCategoryViewModel()
    @StateObject var sponsorVM = SponsorViewModel(name: "", homePage: true)
    @EnvironmentObject var selectedTab: CurrentTab
    
    
    @State private var selectedCreator = Creator(fullName: "", image: .logo, podcasts: [], summary: "")
    
    var creators: [Creator] {
        getCreators(category: viewModel.currentCategory ?? "")
    }
    @State private var creatorData: GetPodcastQuery.Data.GetPodcast?
    @State private var showSelection = false
    
    
    var categories: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?] {
        viewModel.categoryData?.filter {$0?.name != "news & politics"} ?? []
    }
        
    
    var dataLoaded: Bool {
        if ( !viewModel.podcasts.isEmpty && !sponsorVM.trendingSponsors[0].isEmpty ) {
            return true
        } else {
            return false
        }
    }
        
    
    @State private var viewLoaded = false
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.5), .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                if !dataLoaded  {
                    Image(.logo)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                    
                    LoadingAnimation(homeScreen: true)
                    
                } else
               
              {
                  ScrollViewReader { reader in
                      ScrollView  {                         
                          VStack {
                              HStack(alignment:.top) {
                                  GreetingView()
                                     
                                  Spacer()
                                  NavigationLink(value: Navigation.qtna) {
                                      Image(systemName: "questionmark.circle")
                                          .resizable()
                                          .scaledToFit()
                                          .frame(width: 35, height: 35)
                                          .foregroundStyle(.gray)
                                  }
                                 
                              }
                             
                              .padding(20)
                             
                              Spacer()
                          }
                          .id(Self.topId)
                          
                   
                          PodcastSlider(viewModel: viewModel, categories: categories, podcasts: $viewModel.podcasts)
                          
                          PopularCreators(currentCategory: $viewModel.currentCategory)
                          
                          VStack {
                              PopularSponsors(sponsorVM: sponsorVM)
                          }
                          .frame(alignment:.center)

                      }
                      .onChange(of: shouldScrollToTop) {
                                         withAnimation {
                                             reader.scrollTo(Self.topId, anchor: .top)
                                         }
                          setTimeout(0.25) {
                              shouldScrollToTop = false
                          }
                                     }
                  }
                      .padding(.vertical)
              }
              
                }
            .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory?.self ) { category in
                if let category = category {
                    PodcastCategory(category: category)
                }
            }
            .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast.self) { podcast in
                        PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
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
            .navigationDestination(for: Navigation.self) { _ in
                QuestionsView()
     
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
    NavigationStack {
        HomeScreen(shouldScrollToTop: .constant(false))
            .preferredColorScheme(.dark)

    }
}
