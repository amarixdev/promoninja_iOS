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

class ImageLoader: ObservableObject {
    @Published var uiImage: UIImage?
    
    func fetchImage(url: URL) async throws {
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let image = UIImage(data: data) {
            uiImage = image
        }
    }
}


struct PodcastSlider: View {
    var viewModel: PodcastCategoryViewModel
    var categories: [GetPodcastCategoriesQuery.Data.GetPodcastCategory?]

   @Binding var podcasts: [GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]
    @State private var categoryTapped = false
    @GestureState private var podcastTapped = false
    

      
    var body: some View {
                      
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories, id:\.self) { category in
                  
                    if let name = category?.name {
                        Button(name.capitalized ) {
                      
                            viewModel.currentCategory = name
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
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(podcasts, id: \.self) { podcast in
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
        
        
    }
}

