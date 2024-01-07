//
//  UserView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/31/23.
//

import SwiftUI
import SwiftData
import NukeUI
import ApolloAPI
import PromoninjaSchema

struct SavedOffersView: View {
    private static let topId = "topIdHere"
    var savedOffers: [SavedOffer]    
    @Environment(\.modelContext) var modelContext

    @State var selectedSponsor: GetPodcastQuery.Data.GetPodcast.Sponsor?
    @State var selectedPodcast: GetPodcastQuery.Data.GetPodcast?
    
    var filteredOffers: [SavedOffer] {
        if searchText.isEmpty {
            return savedOffers
        } else {
           return savedOffers.filter { offer in
               guard let sponsor = offer.sponsor else { return false}
               
             return   sponsor.localizedCaseInsensitiveContains(searchText)
            }
        }
       
    }
    
    @StateObject var viewModel = PodcastViewModel(title: GraphQLNullable(stringLiteral: ""))
    @State private var displaySheet = false
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            GradientView()
            if savedOffers.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tap the ")
                        Image(systemName: "bookmark")
                        Text("icon to save an offer")
                    }
                    .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.top, 50)
                .frame(width: UIScreen.main.bounds.width, alignment:.center)
                
               
            } else {
                VStack {
          
                        List {
                            ForEach(filteredOffers) { offer in
                                let index = savedOffers.firstIndex(of: offer)
                                
                                ZStack(alignment:.leading) {
                                    Color.clear
                                        .ignoresSafeArea()
                                        .contentShape(Rectangle())
                                    VStack(alignment:.leading) {
                                        VStack(alignment:.leading) {
                                            HStack(alignment:.center) {
                                                Circle()
                                                    .frame(width: 5, height: 5)
                                                    .foregroundStyle(.green)
                                                Text(offer.sponsor ?? "")
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                
                                                
                                                Button {
                                                    
                                                } label: {
                                                    Text(offer.category ?? "")
                                                        .font(.caption)
                                                        .padding(.vertical, 5)
                                                        .padding(.horizontal, 10)
                                                        .background(.ultraThinMaterial)
                                                        .cornerRadius(10)

                                                }
                                                
                                            }
                                            HStack {
                                                
                                                Text(offer.offer ?? "")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                                    .padding(.bottom)
                                            }
                                           
                                        }
                               
                            
                                        
                                    
                                        
                                        Text("Offered by:")
                                            .font(.caption)
                                        
                                        HStack(spacing: 15) {
                                            LazyImage(url: URL(string: offer.podcast.image ?? "")) {
                                                phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                        .cornerRadius(10)
                                                        .shadow(color:.black, radius: 5, x: 3, y: 5)
                                                } else {
                                                    Placeholder(frameSize: 50, imgSize: 35, icon: .podcast)
                                                }
                                                
                                            }
                                            
                                            VStack(alignment:.leading) {
                                                Text(offer.podcast.title?.truncated(30) ?? "")
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                Text(offer.podcast.publisher?.truncated(30) ?? "")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                            }
                                           
                                        }
                                       

                                        .padding(.bottom, 10)
                                        
                                       
                                    }
                                }
                               
                                  
                                    .onTapGesture {
                                            
                                        Task {
                                            let title = GraphQLNullable<String>(stringLiteral: offer.podcast.title ?? "")
                                            
                                            Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
                                                guard let data = try? result.get().data else { return }
                                                
                                                if let podcastData = data.getPodcast {
                                                    DispatchQueue.main.async {
                                                        self.selectedPodcast = (podcastData)
                                                        
                                                        if let selectedSponsor = podcastData.sponsors?.first(where: { sponsor in   sponsor?.name == offer.sponsor
                                                        }) {
                                                            self.selectedSponsor = selectedSponsor
                                                            if self.selectedSponsor != nil {
                                                                self.displaySheet = true
                                                                      }
                                                           
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                  
                                .id(index == 0 ? Self.topId: Self.topId)
                                .listRowBackground(Color.sponsorTheme.opacity(0.25))
                                .listRowSeparator(.hidden)

                            }
                            .onDelete(perform: deleteOffer)
                      
                        }
                        .listStyle(.plain)
                        .listRowSpacing(30)

                }
                .padding(.top, 20)
            }
           
            
        }
        .searchable(text: $searchText)

        .sheet(isPresented: $displaySheet) {
            ZStack {
                LinearGradient(colors: [Color(.sponsorTheme).opacity(0.85), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom)
                
                SponsorDetailSheet(favoritePage: true, podcast: $selectedPodcast , sponsor: $selectedSponsor)
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.clear)
            }

        }
     
        .navigationTitle("Saved Offers (\(savedOffers.count))")
        .toolbar {
            if !savedOffers.isEmpty {
                EditButton()
            }
           
        }
        .toolbarStyle(inline: false)
    }
 
    
    
    func deleteOffer(offsets: IndexSet) {
        for offset in offsets {
            let offer = savedOffers[offset]
            modelContext.delete(offer)
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: SavedOffer.self, configurations: config)
     
        
        let crimeJunkie = SavedOffer.Podcast(title: "Crime Junkie", image: "https://i.scdn.co/image/ab6765630000ba8af4ee04946306cf39d230a073", publisher: "audiochuck")
        
        let jre = SavedOffer.Podcast(title: "The Joe Rogan Experience", image: "https://i.scdn.co/image/9af79fd06e34dea3cd27c4e1cd6ec7343ce20af4", publisher: "Joe Rogan")
        
    let offers = [
                SavedOffer(podcast: crimeJunkie , sponsor: "Athletic Greens", offer: "Get 5 free travel packs plus a 1-year supply of vitamin D", category: "Health & Wellness"),
                SavedOffer(podcast: jre, sponsor: "Better Help", offer: "Get 10% off your first month", category: "Health & Wellness")
    ]
        
        
        
   return 
        NavigationStack {
            SavedOffersView(savedOffers: offers)
                .preferredColorScheme(.dark)
                .modelContainer(container)
        }
        
        
        
    } catch  {
        return Text("No Data error: \(error.localizedDescription)")
    }
   
    
    
}
