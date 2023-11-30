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
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack {
                Image(creator.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text(creator.fullName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Which of my podcasts are you searching for")
                    .opacity(0.8)
                    .font(.footnote)
                    .onTapGesture {
                       print (podcasts)
                    }
                
                Divider()
            }
           
            

            
            if !podcasts.isEmpty  {
                VStack(alignment: .leading) {
                    ForEach(podcasts, id: \.self) {podcast in
                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: podcast.imageUrl ?? "")) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(10)
                                }
                                
                            }
                            
                            Text(podcast.title)
                                .font(.caption)
                                .fontWeight(.semibold)
                                
                           Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .onTapGesture {
                            withAnimation {
                                tapped = podcast.title
                            }
                          
                            Router.router.path.append(podcast)
                            dismiss()
                        }
                        .background( tapped == podcast.title ? .gray.opacity(0.35) : .clear)
                        .cornerRadius(10)
                      
                    }
                }
              
            }
        }
        .padding()
        .onAppear {
            for podcastTitle in creator.podcasts {
                getPodcastData(title: GraphQLNullable(stringLiteral: podcastTitle))
            }
        }
        .padding(.horizontal)
       
        
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
    PodcastSelectionSheet(creator:.constant( Creator(fullName: "Bobby Lee", image: .bobby, podcasts: ["Bad Friends", "TigerBelly"])))
        .preferredColorScheme(.dark)
}


