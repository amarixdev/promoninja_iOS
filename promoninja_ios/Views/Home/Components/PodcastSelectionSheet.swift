//
//  PodcastSelectionView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/29/23.
//

import SwiftUI
import PromoninjaSchema

struct PodcastSelectionSheet: View {
    @Binding var creator: Creator
    @State private var podcasts = [ GetPodcastQuery.Data.GetPodcast]()
    @State private var tapped = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currentTab: CurrentTab
    
    let router = Router.router
    
    var body: some View {
        VStack {
            
            VStack {
                Image(creator.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text(creator.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                Text(creator.summary)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .opacity(0.8)
            
            }
            
            .padding(.top)
            .padding(.bottom, 40)
           
            

            let multiplePodcasts = creator.multiplePodcasts
            VStack {
                Text(multiplePodcasts ? "Check out my podcasts" : "Check out my podcast")
                    .font(.headline)
                    .onTapGesture {
                       print (multiplePodcasts)
                    }
                
                Text("Listeners can enjoy various discounts.")
                    .font(.caption)
                    .opacity(0.8)
            }
            .padding(.bottom, 10)
      
                VStack() {
        
                    if !podcasts.isEmpty
                    {
        
                        Divider()
                        HStack {
                            ForEach(podcasts, id: \.self) {podcast in
                                ZStack {
                                    Color.clear
                                        .contentShape(Rectangle())
                                        .frame(width: .none, height: 80)
                                        .cornerRadius(10)
                                     
                               
                                        HStack(spacing: 10) {
                                            AsyncImage(url: URL(string: podcast.imageUrl ?? ""), transaction: Transaction(animation: .bouncy)) { phase in
                                                if let image = phase.image {
                                                    image.resizable()
                                                        .frame(width: 60, height: 60)
                                                        .cornerRadius(10)
                                                } else {
                                                    Placeholder(frameSize: 60, imgSize: 30, icon: .podcast)
                                                    
                                                }
                                            }
                                            
                                            Text(multiplePodcasts ? podcast.title.truncated(15) : podcast.title)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                           
                                            Spacer()
                                            
                                        }
                                       
                                        .padding(.vertical, 10)
                                   
                                   
                                }
                                .onTapGesture {
                                    print("l")
                                    withAnimation {
                                        tapped = podcast.title
                                    }
                                  
                                    router.homePath.append(podcast)
                                    dismiss()
                                }
                               
                              
                              
                                
                             
                               
                              
                            }
                        }
                    
                    }
                    else {
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: .none, height: 88)
                            .cornerRadius(10)
                    }
                }
              
            Spacer()
        }
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


