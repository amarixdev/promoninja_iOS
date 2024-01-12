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
    
    @State private var scrollOffset =  CGFloat()
    
    
    @State private var selectedCreator = Creator(fullName: "", image: .logo, podcasts: [], summary: "")
    
    var creators: [Creator] {
        getCreators(category: viewModel.currentCategory ?? "")
    }
    @State private var creatorData: GetPodcastQuery.Data.GetPodcast?
    @State private var showSelection = false
    @StateObject var router = Router.router

    
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
      
    @State private var displayNavTitle = false
    
    
    @State private var viewLoaded = false
    var body: some View {
        ZStack {
            GradientView()
            
            ScrollViewReader { reader in
                ScrollView {

                        if !dataLoaded {
                            Image(.logo)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                            LoadingAnimation(homeScreen: true)
                            
                        } else
                          {
             
                                VStack {
                                    HStack(alignment:.top) {
                                        GreetingView()
                                        Spacer()
  
                                    }
                                    .padding(.leading, 25)
                                    .id(Self.topId)
                                                                    
                                    PodcastSlider(viewModel: viewModel, categories: categories, podcasts: $viewModel.podcasts)
                                        .padding(.top, 20)
                                        
                                       
                                    
                                    PopularCreators(currentCategory: $viewModel.currentCategory)
                                        .padding(.horizontal)
                                    
                                    VStack {
                                        PopularSponsors(sponsorVM: sponsorVM)
                                    }
                                    .frame(alignment:.center)

                                
                            
                                .padding(.vertical)
                                    
                                }
                                .background {
                                    GeometryReader { geo in
                                        
                                        Color.clear
                                            .onChange(of: geo.frame(in: .global).minY) {
                                            let offset = geo.frame(in: .global).minY
                                                if offset < 10 {
                                                    self.scrollOffset = offset
                                                    if !displayNavTitle {
                                                        displayNavTitle = true
                                                    }
                                                    
                                                } else if offset > 10 {
                                                    if displayNavTitle {
                                                        displayNavTitle = false
                                                    }
                                                }
                                          
                                                
                                            
                                        }
                                    }
                                    
                                }
                                
                                
                            
                                  
                                                        
                          }
                        
                        
                        
                    
                
                      
                        
                    
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
        }
        
            .toolbar {
                Button {
                    router.homePath.append(Navigation.qtna)
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(displayNavTitle ? .appTheme.opacity(0.5) : .appTheme)
                        Image(systemName: "questionmark")
                            .imageScale(displayNavTitle ? .small : .small)
                    }
                  
                }
            }
            
            .navigationTitle(displayNavTitle ? "Home" : "")
            .navigationBarTitleDisplayMode(.inline)
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

struct CustomLargeTitleView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Custom Large Title View
                HStack {
                    Image(systemName: "star.fill") // Example icon
                    Text("Custom Large Title").font(.largeTitle) // Your custom title
                }
                .padding()
                .background(Color.white) // Background for the title area
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        HomeScreen(shouldScrollToTop: .constant(false))
            .preferredColorScheme(.dark)

    }
}
