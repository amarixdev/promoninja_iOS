//
//  SearchView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/7/23.

import SwiftUI
import PromoninjaSchema
import Fuse
import NukeUI



struct DiscoverView: View {
    @StateObject var viewModel = SearchViewModel()
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    @Binding var shouldScrollToTop: Bool
    @State var selectedCategoryTitle = ""
    
    

    var body: some View {
            if viewModel.podcasts.isEmpty && viewModel.sponsors.isEmpty {
                GradientView()
            } else {
                
                SearchingView(currentCategory: $viewModel.currentCategory, shouldScrollToTop: $shouldScrollToTop, filteredSponsors: $viewModel.filteredSponsors, filteredPodcasts: $viewModel.filteredPodcasts, selectedCategoryTitle: $selectedCategoryTitle)
                    .searchable(text: $viewModel.searchText, prompt: viewModel.currentCategory == .Podcast ? "Find a podcast - \"Bad Friends\"" : "Find a sponsor - \"Tushy\"")
                    
                    .searchScopes($viewModel.currentCategory) {
                        Text("Podcast").tag(Category.Podcast)
                        Text("Sponsor").tag(Category.Sponsor)
                        
                    }

                    .onChange(of: viewModel.searchText) {
                        if viewModel.searchText.isEmpty && !isSearching {
                            dismissSearch()
                        }
                    }
                    .navigationTitle("Discover More")

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
                
                    .navigationDestination(for: GetPodcastsQuery.Data.GetPodcast.self) { podcast in
                        PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
                    }
                    .navigationDestination(for: GetSponsorsQuery.Data.GetSponsor.self) { sponsor in
                        SponsorView(name: sponsor.name ?? "")
                    }
                    .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.self) { category in
                        CategoryView(category: category, selectedCategoryTitle: $selectedCategoryTitle )
                    
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


struct SearchingView: View {
    let searchCategories: [ Category] = [.Podcast, .Sponsor]
    @Environment(\.isSearching) var isSearching
    @StateObject var viewModel = SearchViewModel()

    @StateObject var categoryVM = SponsorCategoriesViewModel()
    
    @Binding var currentCategory: Category
    @Binding var shouldScrollToTop: Bool

    @Binding var filteredSponsors:[GetSponsorsQuery.Data.GetSponsor?]
    @Binding var filteredPodcasts: [GetPodcastsQuery.Data.GetPodcast?]
    @Binding var selectedCategoryTitle: String
    @State private var all_podcasts = [GetPodcastsQuery.Data.GetPodcast?]()

    var categories: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?] {
            categoryVM.categoryData ?? []
        }
      

    var body: some View {
        if categories.isEmpty {
            
            GradientView()
            
        } else
        
        {
            ZStack {
                GradientView()
                if !isSearching {
                    Discover( categories: categories, shouldScrollToTop: $shouldScrollToTop, selectedCategoryTitle: $selectedCategoryTitle)
                } else {
                    VStack {
                            if currentCategory == .Podcast {
                               
                                List {
                                    ForEach(filteredPodcasts, id:\.self) { podcast in
                                        
                                        let index = filteredPodcasts.firstIndex(of: podcast)
                                        
                                        
                                        NavigationLink(value: podcast){
                                            HStack(spacing: 15) {
                                                LazyImage(url: URL(string: podcast?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: index == 0 ? 100 : 60, height: index == 0 ? 100 : 60)
                                                            .cornerRadius(10)
                                                            .shadow(color:.black, radius: 6, x: 3, y: 3)
                                                 
                                                    } else {
                                                        Placeholder(frameSize: index == 0 ? 100 : 60, imgSize: 25, icon: .podcast)
                                                    }
                                                }
                                                
                                                VStack(alignment:.leading) {
                                                    Text(podcast?.title.truncated(30) ?? "")
                                                        .font(.subheadline)
                                                        .fontWeight(.medium)
                                                    Text(podcast?.publisher?.truncated(30) ?? "")
                                                        .font(.subheadline)
                                                        .opacity(0.8)
                                                }
                                                Spacer()
                                       
                                                
                                            }
                                            
                                        }
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .ignoresSafeArea()

                                    }
                                }
                                .listStyle(.plain)

                            } else  {
                                List {
                                    ForEach(filteredSponsors, id:\.self) { sponsor in
                                                                        
                                        let index = filteredSponsors.firstIndex(of: sponsor)

                                        NavigationLink(value: sponsor){
                                            HStack(spacing: 15) {
                                                LazyImage(url: URL(string: sponsor?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: index == 0 ? 100 : 60, height: index == 0 ? 100 : 60)
                                                            .cornerRadius(10)
                                                            .shadow(color:.black, radius: 6, x: 3, y: 3)
                                                 
                                                    } else {
                                                        Placeholder(frameSize: index == 0 ? 100 : 60, imgSize: 25, icon: .sponsor)
                                                    }
                                                }
                                                
                                                VStack(alignment:.leading) {
                                                    Text(sponsor?.name?.truncated(30) ?? "")
                                                        .font(.subheadline)
                                                        .fontWeight(.medium)
                                                    Text(sponsor?.url?.truncated(30) ?? "")
                                                        .font(.subheadline)
                                                        .opacity(0.8)
                                                }
                                                Spacer()
                                       
                                                
                                            }
                                            
                                        }
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .ignoresSafeArea()

                                        
                                       
                                    }
                                }
                                .listStyle(.plain)
                                
                            }
                          
                            
                           
                        }
                    
                }
               
                
                
            }
        }


     
        
    }
}
