//
//  PodcastCategory.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/11/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct PodcastCategory: View {
    let categoryName: String
    @State private var category: GetPodcastCategoriesQuery.Data.GetPodcastCategory?
    
    var podcasts: [GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]? {
        var podcasts = category?.podcast
        
        if sortByOffer || sortByAZ {
            podcasts = sortedPodcasts
        }
        if !searchText.isEmpty {
            
            podcasts = filteredPodcasts
        }
        
        return podcasts
            
    }
    
    var sortedPodcasts: [GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]? {
    var podcasts = category?.podcast
        if sortByOffer {
            if reverseSort {
                podcasts?.sort(by: { a, b in
                    b?.sponsors?.count ?? 0 > a?.sponsors?.count ?? 0
                })
                
            } else {
                podcasts?.sort(by: { a, b in
                    a?.sponsors?.count ?? 0 > b?.sponsors?.count ?? 0
                })
                
            }
        } else if sortByAZ {
            if reverseSort {
                podcasts?.sort(by: { a, b in
                    a?.title ?? "" > b?.title ?? ""
                })
                
            } else {
                podcasts?.sort(by: { a, b in
                    b?.title ?? "" > a?.title ?? ""
                })
                
            }
            
        }
        
     
       
        
        return podcasts ?? category?.podcast
    }
    
    var filteredPodcasts:[GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast?]? {
        let podcasts = category?.podcast?.filter { podcast in
            guard let title = podcast?.title else { return false}
            return ((title.localizedCaseInsensitiveContains(searchText)) == true )
        }
        
        return podcasts
    }
    

    
    @State private var sortByOffer = false
    @State private var sortByAZ = true
    @State private var searchText = ""
    
    @State private var reverseSort = false
    
    var body: some View {

        ZStack {
        GradientView()
            if ((podcasts?.isEmpty) == true) {
                LoadingAnimation(homeScreen: false)
            }
            else
            {
                VStack {
                    ScrollView {
                        
                        ForEach(podcasts ?? [] , id:\.self) { podcast in
                            if let podcast = podcast {
                             
                                NavigationLink(value: podcast){
                                    HStack(spacing: 15) {
                                            LazyImage(url: URL(string: podcast.imageUrl ?? "")) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80, height: 80)
                                                        .cornerRadius(10)
                                                } else {
                                                    Placeholder(frameSize: 80, imgSize: 45, icon: .podcast)
                                                }
                                            }
                                            VStack(alignment:.leading) {
                                                Text(podcast.title )
                                                    .font(.subheadline)
                                                    .lineLimit(1)
                                                
                                                Text(podcast.publisher ?? "")
                                                    .font(.caption)
                                                    .opacity(0.8)
                                                    .lineLimit(1)
                                                
                                                HStack(spacing: 5) {
                                                    Text("Offers:")
                                                        .font(.caption)
                                                    Text(String (podcast.sponsors?.count ?? 0))
                                                        .font(.caption.bold())
                                                }
                                                .padding(.vertical, 5)
                                                .padding(.horizontal, 8)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(10)
                                            }
                                            Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .imageScale(.large)
                                            .opacity(0.4)
                                        }
                                }
                                .padding()
                                
                                Divider()
                                
                              
                            }
                        
                        }
                    }
                }
                .padding(.top, 20)
            }
            
         
             
        }
        .task {
            Network.shared.apollo.fetch(query: GetPodcastCategoriesQuery(input: GraphQLNullable (IOSInput(isPodcastCategoryPage: true)) )) { result in
                guard let data = try? result.get().data else { return }
                    
                if let categoryData = data.getPodcastCategories {
                    
                    let currentCategory = categoryData.filter { category in
                       category?.name ?? "" == categoryName
                    }[0]
                    
                    DispatchQueue.main.async {
                        self.category = currentCategory
                        
                    }
                }
            }
        }
        .searchable(text:$searchText)
        .navigationTitle(categoryName.capitalized)
        .toolbarStyle(inline: false)
        .toolbar {
            Menu {
                Button {
                    if sortByAZ {
                        reverseSort.toggle()
                    } else {
                        sortByAZ = true
                        sortByOffer = false
                        reverseSort = false
                    }
                } label: {
                    Label("Title", systemImage: sortByAZ ? "checkmark" : "")
                }
                

                Button {
                    
                    if sortByOffer {
                        reverseSort.toggle()
                    } else {
                        sortByOffer = true
                        sortByAZ = false
                        reverseSort = false
                    }

                } label: {
                    Label("Offer count", systemImage: sortByOffer ? "checkmark" : "")
                }
           
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(.appTheme)
                    Image(systemName: "arrow.up.arrow.down")
                        .imageScale(.small)

                }
               
                
            }
        }
     
    }
}

//#Preview {
//    PodcastCategory()
//}
