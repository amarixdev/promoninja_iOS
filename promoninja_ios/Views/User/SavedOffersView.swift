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
    @StateObject var router = Router.router

    var filteredOffers: [SavedOffer] {
        if searchText.isEmpty {
            return savedOffers
        } else {
           return savedOffers.filter { offer in
               guard let sponsor = offer.sponsor.name else { return false}
               
               return  sponsor.localizedCaseInsensitiveContains(searchText)
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
                                            HStack(alignment:.top) {
                                                
                                                
                                         
                                                    LazyImage(url: URL(string: offer.sponsor.image ?? "")) {
                                                            phase in
                                                            if let image = phase.image {
                                                                image
                                                                    .resizable()
                                                                    .frame(width: 80, height: 80)
                                                                    .cornerRadius(10)
                                                                    .shadow(color:.black, radius: 5, x: 3, y: 5)
                                                            } else {
                                                                Placeholder(frameSize: 80, imgSize: 50, icon: .podcast)
                                                            }
                                                            
                                                    }
                                                    .onTapGesture {
                                                        router.userPath.append(offer.sponsor)
                                                    }
                                                

                                                
                                                VStack(alignment:.leading) {
                                                    Text(offer.sponsor.name ?? "")
                                                        .font(.title3)
                                                        .fontWeight(.semibold)
                                          
                                                    
                                                       Text(offer.sponsor.category ?? "")
                                                               .font(.caption)
                                                               .padding(.vertical, 5)
                                                               .padding(.horizontal, 10)
                                                               .background(.ultraThinMaterial)
                                                               .cornerRadius(10)
                                                }
                                                .padding(.leading, 10)
                                              
                                                
                                            }
                                            HStack(alignment:.top) {
                                                Circle()
                                                    .frame(width: 5, height: 5)
                                                    .foregroundStyle(.green)
                                                    .offset(y:6)
                                                    
                                                Text(offer.offer ?? "")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                       
                                            }
                                            .padding(.vertical)
                                  
                                           
                                        }

                                        
                                        VStack(alignment:.leading) {
                                            Text("Offered by:")
                                                .font(.caption)
                                            
                                            HStack(spacing: 15) {
                                                
                                                HStack {
                                                    LazyImage(url: URL(string: offer.podcast.image ?? "")) {
                                                        phase in
                                                        if let image = phase.image {
                                                            image
                                                                .resizable()
                                                                .frame(width: 40, height: 40)
                                                                .cornerRadius(5)
                                                                .shadow(color:.black, radius: 5, x: 3, y: 5)
                                                        } else {
                                                            Placeholder(frameSize: 50, imgSize: 35, icon: .podcast)
                                                        }
                                                        
                                                    }
                                                  
                                                
                                             
                                                
                                                VStack(alignment:.leading) {
                                                    Text(offer.podcast.title?.replacingOccurrences(of: "Fuck", with: "F*ck") ?? "")
                                                        .font(.caption)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(1)
                                                    Text(offer.podcast.publisher ?? "")
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                        .lineLimit(1)
                                                }
                                                }
                                                .onTapGesture {
                                                    router.userPath.append(offer.podcast)
                                                    
                                                }
                                         
                                                Spacer()
                                                Button {
                                                    Task {
                                                        let title = GraphQLNullable<String>(stringLiteral: offer.podcast.title ?? "")
                                                        
                                                        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
                                                            guard let data = try? result.get().data else {

                                                                return }
                                                            
                                                            if let podcastData = data.getPodcast {
                                                                DispatchQueue.main.async {
                                                                    self.selectedPodcast = (podcastData)
                                                                    
                                                                    if let selectedSponsor = podcastData.sponsors?.first(where: { sponsor in   sponsor?.name == offer.sponsor.name
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
                                                } label: {
                                                        Text("Open")
                                                            .font(.caption)
                                                    

                                                }
                                                .buttonStyle(.bordered)
                                               
                                            }
                                           

                                            .padding(.bottom, 10)
                                        }
                                       

                                        
                                       
                                    }
                                }
                               
                                  
                                    .onTapGesture {
                                            
                                       
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
        
        
//        let ag1 = SavedOffer.Sponsor(name: "Athletic Greens", category: "Health & Wellness", image: "https://healthreporter.com/app/uploads/athletic-greens-ag1.jpg")
        
        let blueChew = SavedOffer.Sponsor(name: "BLUECHEW", category: "Health & Wellness", image: "https://i.ytimg.com/vi/RWMjZeud8ys/frame0.jpg")
        
        let ag1 = SavedOffer.Sponsor(name: "Athletic Greens", category: "Health & Wellness", image: "https://healthreporter.com/app/uploads/athletic-greens-ag1.jpg")
        
    let offers = [
                SavedOffer(podcast: crimeJunkie , sponsor: ag1, offer: "Get 5 free travel packs plus a 1-year supply of vitamin D"),
                
                SavedOffer(podcast: jre , sponsor: blueChew, offer: "Get 5 free travel packs plus a 1-year supply of vitamin D")
                
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
