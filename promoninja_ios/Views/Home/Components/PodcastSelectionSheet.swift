//
//  PodcastSelectionView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/29/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct PodcastSelectionSheet: View {
    @Binding var creator: Creator
    @State private var podcasts = [ GetPodcastQuery.Data.GetPodcast]()
    @State private var tapped = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currentTab: CurrentTab
    
    @State private var viewLoaded = false
    let router = Router.router
    
    var body: some View {
        ScrollView {
            VStack {
                
                ZStack {
                    Image(systemName: "")
                    VStack {
                        Image(creator.image)
                            .resizable()
                            .scaledToFill()
                            .frame( height: 300)
                            .overlay {
                                LinearGradient(colors: [.black.opacity(0), .black], startPoint: .top, endPoint: .bottom)
                                    .frame(height: 300)
                            }
                            .clipped()
                    Spacer()
                    }
                  
                    VStack {
                        
                        Text(creator.fullName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                        Text(creator.summary)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .opacity(0.8)
                            .padding(.horizontal)
                    }
                    .padding(.top, 250)
                    
                    .frame(width: UIScreen.main.bounds.width)

                  
                
                }
                .frame(width: UIScreen.main.bounds.width)

                let multiplePodcasts = creator.multiplePodcasts
                VStack {
                    Text(multiplePodcasts ? "Check out my podcasts" : "Check out my podcast")
                        .font(.headline)

                    
                    Text("Listeners can enjoy various discounts.")
                        .font(.caption)
                        .opacity(0.8)
                        .padding(.bottom, 10)
                }
                .padding(.top, 20)
      
          
                VStack(alignment:.leading) {
            
                        if !podcasts.isEmpty
                        {

                                List {
                                    ForEach(podcasts, id: \.self) {podcast in

                                        ZStack {
                                            Color.clear
                                                .contentShape(Rectangle())
                                                .frame( height: 80)
                                                .zIndex(10)
                                                .onTapGesture {
                                                        tapped = podcast.title
                                                    router.homePath.append(podcast)
                                                    dismiss()
                                                }
                                        
                                            HStack {
                                                LazyImage(url: URL(string: podcast.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)) { phase in
                                                    if let image = phase.image {
                                                        image.resizable()
                                                            .frame(width: 70, height: 70)
                                                            .cornerRadius(10)
                                                    } else {
                                                        Placeholder(frameSize: 60, imgSize: 30, icon: .podcast)
                                                        
                                                    }
                                                }

                          
                                                
                                                HStack(alignment:.top) {
                                                    VStack(alignment:.leading) {
                                                        Text(podcast.title)
                                                            .font(.caption)
                                                            .fontWeight(.semibold)
                                                            .lineLimit(1)
                                                        
                                                        Text(podcast.publisher ?? "")
                                                            .font(.caption)
                                                            .opacity(0.8)
                                                            .lineLimit(1)
                                                        
                                                        HStack(spacing: 5) {
                                                            Text("Offers:")
                                                                .font(.caption2)
                                                            Text(String (podcast.sponsors?.count ?? 0))
                                                                .font(.caption2.bold())
                                                        }
                                                        .padding(.vertical, 5)
                                                        .padding(.horizontal, 8)
                                                        .background(.ultraThinMaterial)
                                                        .cornerRadius(10)
                                                            
                                                    }
                                                    .frame(width: 200, alignment: .leading)
                                                    .padding(.horizontal, 5)
                   
                                                }
                                    
                                                Image(systemName: "chevron.right")
                                                    .opacity(0.5)
                                                
                                            }
                                            
                                       
                                        }
                                        .ignoresSafeArea()
                                        .listRowBackground(Color.sponsorTheme.opacity(0.65))
                                        .animation(.easeIn, value: tapped)
                                     
                                    }
                                }
                                .listStyle(.insetGrouped)
                                .scrollContentBackground(.hidden)

                            
                               
                             
                                .fadeInView(viewLoaded: $viewLoaded)
                                .frame(width: UIScreen.main.bounds.width, height: multiplePodcasts ? 300 : 185)
                                .cornerRadius(10)
                            
                        
                        }
                        else {
                            ZStack {
                                ProgressView()
                                Color.clear
                                    .contentShape(Rectangle())
                                    .frame(width: .none, height: 88)
                                    .cornerRadius(10)
                            }
                           
                        }
                    }
         
                
                  
                Spacer()
            }
        }
        .environment(\.colorScheme, .dark)
        .padding()
        .onAppear {
            for podcastTitle in creator.podcasts {
                getPodcastData(title: GraphQLNullable(stringLiteral: podcastTitle))
            }
        }
 
        
       
        
    }
    
    
    
    func getPodcastData (title: GraphQLNullable<String>) {
        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
            guard let data = try? result.get().data else { return }
           
            if let fetchedData = data.getPodcast {
                DispatchQueue.main.async {
                    podcasts.self.append (fetchedData)
                   
                }
            }
        }
    }
}

#Preview {
    PodcastSelectionSheet(creator:.constant( Creator(fullName: "Bobby Lee", image: .bobby, podcasts: ["Bad Friends", "TigerBelly"],  summary: "Joseph James Rogan is an American UFC color commentator, podcaster, comedian, actor, and former television host. He hosts The Joe Rogan Experience, a podcast in which he discusses current events, comedy, politics, philosophy, science, martial arts, and hobbies with a variety of guests.")))
        .preferredColorScheme(.dark)
}


