//
//  SponsorDetailSheet.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema
import SwiftData





struct SponsorDetailSheet: View {
    @Binding var podcast: GetPodcastQuery.Data.GetPodcast?
    @Binding var sponsor: GetPodcastQuery.Data.GetPodcast.Sponsor?
    @StateObject var router = Router.router
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currentTab: CurrentTab
    @Environment(\.modelContext) var modelContext
       
    @State private var copied = false
    @State private var degrees:Double = 0
    
    @State private var isFavorited = false
    @State private var sensory = false
    
    var matchingOffer: GetPodcastQuery.Data.GetPodcast.Offer? {
         guard let podcast = podcast,
               let offers = podcast.offer
          else { return nil }
                
        guard let sponsorName = sponsor?.name else { return nil }
        
         let matchingOffer = offers.first(where: {$0?.sponsor == sponsorName})
         return matchingOffer!
      }
    
    

    
  
      
      var affiliateLink: String {
          return matchingOffer?.url ?? ""
      }
      
      var promoCode: String {
          return matchingOffer?.promoCode ?? ""
      }
  

 
    
    var body: some View {
        
   
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: isFavorited ? "star.fill" :"star")
                        .onTapGesture {
                            Task {
                                guard let podcastTitle = podcast?.title else {return}
                                guard let sponsorName = matchingOffer?.sponsor else {return}
                                try handleFavorite(podcastTitle: podcastTitle, sponsorName: sponsorName)
                            }
                        }
                    Spacer()
                }
            }
            .padding(.top, 45)
            VStack {
                //header
                HStack(spacing: 15) {
                    if let imageUrl = sponsor?.imageUrl {
                  
                            AsyncImage(url: URL (string: imageUrl)!, transaction: Transaction(animation: .bouncy)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                   
                                } else {
                                    ZStack {
                                      ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                                    .frame(width: 100, height: 100)
                                }
                               
                            }
                            .rotation3DEffect(
                                .degrees(degrees),
                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .onTapGesture {
                                
                                print(currentTab.name)
                                print(router.userPath.count)
                                
                                if let sponsor = sponsor {
                                    if currentTab.name == .home {
                                        router.homePath.append(sponsor)
                                    } else if currentTab.name == .discover {
                                        router.discoverPath.append(sponsor)
                                    } else if currentTab.name == .user {
                                        router.userPath.append(sponsor)
                                    } 
                                    
                                    
                                   
                                }
                                
                                    dismiss()
                                }
                                
                    }
             
                    VStack(alignment:.leading) {
                        Text(sponsor?.name ?? "")
                            .font(.title3.bold())
                        Text(sponsor?.url ?? "")
                            .font(.subheadline)
                            .opacity(0.8)
                 
                    }
                    .frame(width: 200, alignment: .leading)
      
                  
                    Spacer()

                }
                .padding(.vertical)
               
                
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading ,spacing: 15) {
                        Text("Exclusive Offer:")
                            .font(.title3.bold())
                        Text(sponsor?.offer ?? "")
                            .multilineTextAlignment(.leading)
                            .font(.subheadline)
                            .opacity(0.8)
     
                           
                    }
                  
                    
                    VStack(alignment:.leading) {
                        Text("Affiliate Link")
                            .fontWeight(.semibold)
                            .font(.caption)
                            .padding(.leading, 5)
                        
                        Link(destination: URL(string: "https://"+affiliateLink)!, label: {
                            Text(affiliateLink)
                                .font(.subheadline)
                                .opacity(0.8)
                        })
                        .padding(10)
                        .background()
                        .cornerRadius(10)
                    }
                   
                    Divider()
                    
                }
                
               //promoCode Button
              
               Spacer()
                if !promoCode.isEmpty {
                    HStack {
                        VStack(alignment:.leading, spacing: 10) {
                            Text("Use code at checkout")
                                .font(.subheadline)
                                .opacity(0.8)
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = promoCode
                                copied = true
                                withAnimation {
                                    degrees += 360
                                }
                              
                            } label: {
                                HStack {
                                    ZStack {
                                        Text(promoCode.uppercased())
                                            .font(.title2)
                                            .fontWeight(.heavy)
                                            .tracking(5)
                                            .opacity(copied ? 0 : 1)
                                        Text("Copied")
                                            .font(.title2)
                                            .fontWeight(.heavy)
                                            .tracking(5)
                                            .opacity(copied ? 1 : 0)
                                    }
                                    .animation(.none, value: copied)
                                    Image(systemName: "doc.on.doc")
                                        .imageScale(.small)
                                }
                               
                               
                            }
                        }
                        Spacer()
                    }
                  
                }
         
                
                Spacer()
            }
        }
     
        .task {

            //Check is offer is favorited
            guard let sponsor = matchingOffer?.sponsor else { return }
            guard let podcast = podcast?.title else { return }
                    
            let fetchDescriptor = FetchDescriptor<SavedOffer>(predicate: #Predicate { offer in
                offer.sponsor == sponsor && offer.podcast.title == podcast
                
            })
            
            do {
                let offer = try modelContext.fetch(fetchDescriptor)
                
                if offer.isEmpty {
                    isFavorited = false
                } else {
                    isFavorited = true
                }
                                    
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
                .sensoryFeedback(.success, trigger: copied)
                .sensoryFeedback(.success, trigger: sensory)

              
            
            .padding()
   
   
    }
    
    func handleFavorite (podcastTitle: String, sponsorName: String) throws {

        if isFavorited {
            //remove favorite
            isFavorited = false
            sensory.toggle()
            do {
                try modelContext.delete(model: SavedOffer.self, where: #Predicate { offer in
                    offer.sponsor == sponsorName && offer.podcast.title == podcastTitle
                })
                
            } catch {
                print("Failed to delete with error: \(error.localizedDescription)")
            }
    
        } else {
            isFavorited = true
            sensory.toggle()
            let favoritedOffer = SavedOffer(podcast: .init(title: podcast?.title ?? "", image: podcast?.imageUrl ?? "", publisher: podcast?.publisher ?? ""), sponsor: matchingOffer?.sponsor ?? "", offer: sponsor?.offer ?? "", category: sponsor?.sponsorCategory?[0]?.name ?? "")
                    
            modelContext.insert(favoritedOffer)
        }
        
    }

    
    
}

//#Preview {
//    SponsorDetailSheet()
//}
