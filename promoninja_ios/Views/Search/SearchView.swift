//
//  SearchView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/7/23.

import SwiftUI
import PromoninjaSchema
import Fuse
import NukeUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch

    var body: some View {
  
        SearchingView(viewModel: viewModel, currentCategory: $viewModel.currentCategory, searchText: $viewModel.searchText)
      

            .searchable(text: $viewModel.searchText, prompt: viewModel.currentCategory == .Podcast ? "Find a podcast to support" : "Find a product or service")
        
            .onChange(of: viewModel.searchText) {
                if viewModel.searchText.isEmpty && !isSearching {
                    dismissSearch()
                }
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
        
        .navigationDestination(for: GetPodcastsQuery.Data.GetPodcast.self) { podcast in
            PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
                }
        
        
     
    }
    
}

#Preview {
    NavigationStack {
        SearchView()
            .preferredColorScheme(.dark)
    }
   
}


struct SearchingView: View {
    let searchCategories: [ SearchViewModel.Category] = [.Podcast, .Sponsor]
    var viewModel: SearchViewModel
    @Binding var currentCategory: SearchViewModel.Category
    
    @Binding var searchText: String
    
    @Environment(\.isSearching) var isSearching

    
    @State private var all_podcasts = [GetPodcastsQuery.Data.GetPodcast?]()

 
    var searchTheme: Color? {
        var rgbString: String = ""
        if let firstIndexedPodcast = viewModel.filteredPodcasts[0]{
            rgbString = firstIndexedPodcast.backgroundColor ?? "rgb(0,0,0)"
        }
      
        return Color(rgbString: rgbString)
        
    }
    


    var body: some View {
        ZStack {
   
            if !viewModel.filteredPodcasts.isEmpty {
                if let searchTheme = searchTheme {
                    LinearGradient(gradient: Gradient(colors: [searchTheme, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .animation(.easeIn(duration: 0.25), value: searchTheme)
             
                } else {
                    LinearGradient(gradient: Gradient(colors: [.sponsorTheme.opacity(0.75), .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .animation(.easeIn(duration: 0.25), value: viewModel.filteredPodcasts.isEmpty)
                }
            }
            else {
                LinearGradient(gradient: Gradient(colors: [.sponsorTheme.opacity(0.75), .black, Color.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .animation(.easeIn(duration: 0.25), value: viewModel.filteredPodcasts.isEmpty)
            }
            
            
           if isSearching {
                VStack {
                    Picker("Search for a podcast or sponsor", selection: $currentCategory) {
                        ForEach(searchCategories, id: \.self) { category in
                            Text(category.rawValue)
                            }
                        }
                        .onTapGesture {
                            if viewModel.currentCategory == .Podcast {
                                viewModel.currentCategory = .Sponsor
                                        } else {
                                            viewModel.currentCategory = .Podcast
                                        }
                                    }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        Spacer()
                
                    if viewModel.currentCategory == .Podcast {
                        List {
                            ForEach(viewModel.filteredPodcasts, id:\.self) { podcast in

                                NavigationLink(value: podcast){
                                    HStack {
                                        LazyImage(url: URL(string: podcast?.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(10)
                                         
                                            } else {
                                                Placeholder(frameSize: 60, imgSize: 25, icon: .podcast)
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
                                .background(.clear)
                                .padding(.vertical, 10)
                                
                               
                            }
                        }
                        .listStyle(.plain)
                        
                                          
                     
                    } else {
                        ForEach(viewModel.filteredSponsors.prefix(10), id:\.self) { sponsor in
                            Text(sponsor?.name ?? "")
                        }
                    }
                  
                    
                   
                }
            }
            
        }
   
        

     
        
    }
}
