//
//  Podcast.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI
import SwiftData


struct PodcastView: View {
    @StateObject var viewModel: PodcastViewModel
    @Environment(\.dismiss) var dismiss
    
    
    @State private var shine = false
    @State private var disableTap = false
    @State private var sensory = false
    @Environment(\.modelContext) var modelContext
    var title: GraphQLNullable<String>
    
    init(title: GraphQLNullable<String>) {
        self.title = title
        self._viewModel = StateObject(wrappedValue: PodcastViewModel(title: title))
        
    }

    var podcast: GetPodcastQuery.Data.GetPodcast? {
            viewModel.podcastData
    }
    
    
    var noSponsors: Bool {
        return  ((viewModel.podcastData?.sponsors?.isEmpty) == true)
    }
    
    
    var podcastTheme: Color {
        return Color(rgbString: podcast?.backgroundColor ?? "rgb(0,0,0)")
    }
    
    var logoMessage: String {
        if noSponsors {
           return  "Oops! No available sponsors. Check again later."
            
        } else {
            
           return  "Empower your favorite podcaster by making your purchase through their affiliate link."
        }
       
    }
    
    
    @State private var showMore = true
    @State private var imgLoaded = false
    @State private var viewLoaded = false
    
    @State private var isFavorited = false
    var body: some View {
        
        
        if podcast?.imageUrl == nil  {
            LoadingAnimation(homeScreen: false)
                .toolbarStyle(inline: true)
          
        } else {
          
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [podcastTheme, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        
                   ScrollView {
                        VStack {
                        
                                LazyImage(
                                    url: URL(string: podcast?.imageUrl ?? "")!, transaction: Transaction(animation: .bouncy)
                                ) { phase in
                                    if let image = phase.image {
                                      
                                        image.resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(width: 180, height: 180)
                                             .cornerRadius(10)
                                             .shadow(radius: 10)
                                             .shine(shine)
                                             .onTapGesture {
                                                 if !disableTap {
                                                     shine.toggle()
                                                 }
                                                disableTap = true
                                                 setTimeout(1.6) {
                                                     disableTap = false
                                                 }
                                             }
                                             
                                             
                                    }
                                    
                                    else if phase.error != nil {
                                        Placeholder(frameSize: 180, imgSize: 55, icon: .podcast)
                                          
                                    } else {
                                        Rectangle()
                                            .frame(width: 180, height: 180)
                                            .cornerRadius(10)
                                            .foregroundStyle(.white.opacity(0))
                                    }
                                  
                                      
                                }
                                .padding(.bottom, 15)
              
                            if let publisher = podcast?.publisher {
                                Text(publisher.truncated(35))
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    
                            }
              
                            
                            if let description = podcast?.description {
                                VStack(spacing: 15) {
                                    DisclosureGroup(isExpanded: $showMore) {
                                        VStack(alignment:.leading) {
                                            Link(destination: URL(string: (podcast?.externalUrl!)!)!) {
                                                HStack {
                                                    Image(systemName: "play.circle")
                                                        .foregroundStyle(.green)
                                                    Text("Listen on Spotify")
                                                        .font(.caption.bold())

                                                }
                                                .padding(.top, 10)
                                            }
                                     
                                         
                                            TruncateView(text: description)
                                        }
                                      
                                    } label: {
                                        Button {
                                            withAnimation {
                                                showMore.toggle()
                                            }
                                           
                                        } label: {
                                            Text(showMore ? "Hide details" : "See details")

                                        }
                                        .buttonStyle(.bordered)
                                        .padding(.bottom)
                                        .animation(.none, value: showMore)
                                    }

                                  
                               
                                        .font(.subheadline)
                      

                                }
                                
                                .transition(.move(edge: .bottom))
                                .padding(20)
                                .opacity(0.8)
                          
                              
                            }
                            
                                
                               
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: .none, height: 90)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .shadow(color: .black, radius: 20)
                                
                                VStack(spacing: 12) {
                                    Text("Thanks for supporting the show.")
                                        .font(.subheadline)
                                        .opacity(0.8)
                                   
                                }
                           
                            }
                            .padding(.vertical, 40)

                            
                            
                            VStack {
                                Image(.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                                Text("""
                                           \(logoMessage)
                                           
                                           """)
                                    .multilineTextAlignment(.center)
                                   
                                    .italic()
                                    .font(.subheadline)
                                    .opacity(0.8)
                            }
                            .frame(width: 300)
                            
                            //Buttons
                   
                           
                            //Sponsors
                            HStack {
                              
                                
                            }
                            .padding(.leading)
                               
                            if !noSponsors {
                                SponsorListView(podcast: podcast)
                            }
                            
                              
                          
                        
                            Spacer()
                        }
                    }
              
                   .padding(.vertical)
                   .padding(.horizontal, 0)
                   
                   
                   
                    
                    
                }
                .fadeInView(viewLoaded: $viewLoaded)
                .sensoryFeedback(.success, trigger: sensory)
                .task {
                    //Check is podcast is favorited
                    guard let podcastTitle = podcast?.title else { return }
                                        
                    do {
                        let fetchDescriptor = FetchDescriptor<FavoritePodcast>(predicate: #Predicate { favoritePodcast in
                            favoritePodcast.title == podcastTitle
                        })
                        
                        let podcast = try modelContext.fetch(fetchDescriptor)
                        
                        if podcast.isEmpty {
                            isFavorited = false
                        } else {
                            isFavorited = true
                        }
                                            
                    } catch {
                        print("error: \(error.localizedDescription)")
                    }
                }
                .navigationTitle(podcast?.title.truncated(25) ?? "")
                .toolbar {
                    Button {
                        Task {
                            try handleFavorite(podcastTitle: podcast?.title ?? "")
                        }
                        
                    } label: {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .imageScale(.medium)
                    }
                }
                .toolbarStyle(inline: true)
        }
    }
    
    
    
    
    func handleFavorite (podcastTitle: String) throws {

        if isFavorited {
            //remove favorite
            isFavorited = false
            sensory.toggle()
            do {
                try modelContext.delete(model: FavoritePodcast.self, where: #Predicate { podcast in
                    podcast.title == podcastTitle
                })
                
            } catch {
                print("Failed to delete with error: \(error.localizedDescription)")
            }
    
        } else {
            isFavorited = true
            sensory.toggle()
            
            let favoritePodcast = FavoritePodcast(title: podcast?.title ?? "", image: podcast?.imageUrl ?? "", publisher: podcast?.publisher ?? "", sponsorCount: podcast?.sponsors?.count ?? 0)
                   
            modelContext.insert(favoritePodcast)
        }
        
    }

}

#Preview {
    NavigationStack {
        PodcastView( title: "Aubrey Marcus Podcast")
            .preferredColorScheme(.dark)
            .modelContainer(for: FavoritePodcast.self)
    }
   
}
