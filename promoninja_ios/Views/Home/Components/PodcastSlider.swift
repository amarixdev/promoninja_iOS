//
//  PodcastSlider.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/6/23.
//

import SwiftUI
import PromoninjaSchema
import Nuke
import NukeUI

struct GetCategory: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}


struct PodcastSlider: View {
    var viewModel: PodcastCategoryViewModel
    var categories: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?]

    private static let topId = "topIdHere"
    @State private var shouldScrollToTop = false
    
    @Binding var podcasts: [GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]
    @State private var categoryTapped = false
    @GestureState private var podcastTapped = false
    
    @State private var shouldScrollToStart = false
    @State private var categoryID = ""
    @State private var fadeOutList = false
    @State private var shouldFade = false
    @State private var xOffset = CGFloat()
    
    var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories, id:\.self) { category in
                      
                        if let name = category?.name {
                            Button(name.capitalized ) {
                                viewModel.currentCategory = name
                                shouldScrollToStart = true
                                categoryTapped = true
                                setTimeout(0.2) {
                                    categoryTapped = false
                                }
                              

                            }
                              .fontWeight(.medium)
                              .font(.subheadline)
                                .buttonStyle(.borderedProminent)
                                .tint(viewModel.currentCategory == name ? .logo : .sponsorTheme)
                                .foregroundStyle(viewModel.currentCategory == name ? .white : .white.opacity(0.8))
                                .animation(.none, value: viewModel.currentCategory == name)
                                .scaleEffect(viewModel.currentCategory == name && categoryTapped ? 0.9 : 1.0)
                                .animation(.bouncy, value: categoryTapped)
                               
                                
                        }
                        
                    }
                }
                .padding(.horizontal, 10)
                
            }
            .sensoryFeedback(.selection, trigger: podcasts)
            .scrollIndicators(.hidden)
    
        
        ScrollViewReader { reader in
            
            ScrollView(.horizontal) {
      
                  
                    LazyHStack(alignment:.center, spacing: 15) {
                        ForEach(podcasts.prefix(8), id: \.self) { podcast in
                            
                            if let index = podcasts.firstIndex(of: podcast) {
                                VStack(alignment:.leading)  {
                                
                                    NavigationLink(value: podcast) {
                                        LazyImage(url: URL(string: podcast?.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)) { phase in
                                            if let image = phase.image {
                                                
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 150, height: 150)
                                                    .cornerRadius(10)
                                                    .scaleEffect(podcastTapped ? 0.9 : 1.0)
                                            }
                                            else
                                            {
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
                                .opacity(fadeOutList ? 0 : 1)
                                .id(String(index) + (podcast?.category?[0]?.name ?? ""))
                                
                                //move 'category' outside scope
                                .preference(key: GetCategory.self, value: podcast?.category?[0]?.name ?? "")

                            }
                                            
                       
                        }
                        NavigationLink(value: viewModel.podcastCategory) {
                            VStack {
                                ZStack {
                                        Circle()
                                        .frame(width: 75, height: 150)
                                        .opacity(0)
                                    HStack(spacing: 0) {
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .opacity(fadeOutList ? 0 : 1)
                                    
                                    }
                                  
                                }
                                Spacer()
                            }
                        
                           
                          
                        }
                       
                }
                    .padding(.vertical, 20)

                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .global).minX) {
                                let offset = geo.frame(in: .global).minX
                                self.xOffset = offset
                            }
                        }
                        
                    }
                
            }
            .onChange(of: xOffset, {
                if xOffset < -75 {
                    if !shouldFade {
                        shouldFade = true
                    }
                }
            })
            
            .onChange(of: shouldScrollToStart) {
                if shouldScrollToStart {
                        withAnimation {
                            reader.scrollTo(String(0) + (viewModel.currentCategory ?? ""))
                        }
                    setTimeout(0.25) {
                        shouldScrollToStart = false

                    }
                    setTimeout(0.5) {
                        shouldFade = false
                    }
                   
                }
             
            }
            .onChange(of: viewModel.currentCategory) {
                if shouldScrollToStart {
                    withAnimation {
                        if shouldFade {
                            fadeOutList = true
                        }
                        reader.scrollTo(String(0) + categoryID)
                    }
                      setTimeout(0.25) {
                        withAnimation {
                            fadeOutList = false
                        }
                    }
    
                    setTimeout(0.15) {
                        shouldScrollToStart = false
                        shouldFade = false
                    }
                   
                }
             
            }
            .onPreferenceChange(GetCategory.self) { newValue in
                categoryID = newValue
            }
            
            
        }
        NavigationLink(value: viewModel.podcastCategory) {
            HStack {
                
                HStack {
                    Text("View more shows: ")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(viewModel.podcastCategory??.name?.capitalized ?? "")
                        .font(.caption)
                        .bold()
                }
                .padding(20)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing)
            }
            .background(.ultraThinMaterial)
            .padding(.vertical, 20)
            .shadow(radius: 5)
        }
            
        
     
      
      
      
        
        
    }
}

