//
//  PodcastDetailSheet.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI
import SwiftData
import MessageUI

struct PodcastDetailSheet: View {
    
    @Environment(\.modelContext) var modelContext
    
   @Binding var podcast: GetSponsorQuery.Data.GetSponsor.Podcast?
    var sponsor: GetSponsorQuery.Data.GetSponsor?
    
    @StateObject var router = Router.router
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currentTab: CurrentTab
    
    @State private var degrees:Double = 0
    @State private var copied = false
    @State private var isFavorited = false
    @State private var sensory = false

    @State private var isShowingMailView = false

    
    var podcastTheme: Color {
        return Color(rgbString: podcast?.backgroundColor ?? "rgb(0,0,0)")
    }
    

    var matchingOffer: GetSponsorQuery.Data.GetSponsor.Podcast.Offer? {
         guard let podcast = podcast,
               let offers = podcast.offer
          else { return nil }
                
     
        
        let matchingOffer = offers.first(where: {$0?.sponsor == sponsor?.name})
        return matchingOffer!
      }
      
        
    var affiliateLink: String {
        return matchingOffer?.url ?? ""
    }
    
    var promoCode: String {
        return matchingOffer?.promoCode ?? ""
    }
    
    
  
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showGratitude = false
    
    var body: some View {
            
        ZStack {
            HStack {
                Spacer()
                VStack(spacing: 10) {
                  
                    Image(systemName: isFavorited ? "bookmark.fill" : "bookmark")
                        .onTapGesture {
                            Task {
                                guard let podcastTitle = podcast?.title else { return }
                                guard let sponsorName = matchingOffer?.sponsor else { return }
                                
                                try handleFavorite(podcastTitle: podcastTitle, sponsorName: sponsorName)
                            }
                        }
                   
                    Spacer()
                }
            }
            .padding(.top, 45)
            VStack {
                //header
                HStack(alignment:.top, spacing: 15) {
                    if let imageUrl = podcast?.imageUrl {
                            LazyImage(url: URL (string: imageUrl)!, transaction: Transaction(animation: .bouncy)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                }
                                else {
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
                                if let podcast = podcast {
                                    if currentTab.name == .home {
                                        router.homePath.append(podcast)
                                    } else if currentTab.name == .discover {
                                        router.discoverPath.append(podcast)
                                    } else if currentTab.name == .user {
                                        router.userPath.append(podcast)
                                    }
                                    dismiss()
                                    }
                                }
                    }
             
                    VStack(alignment:.leading) {
                        Text(podcast?.title ?? "")
                            .font(.title3.bold())
                        Text(podcast?.publisher ?? "")
                            .font(.subheadline)
                            .opacity(0.8)
                    }
                    .frame(width: 200, alignment: .leading)
      
                  
                    Spacer()
                    

                }
                .padding(.vertical)
                
                VStack(alignment:.leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 15) {
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
                        HStack {
                            Link(destination: URL(string: "https://www."+affiliateLink)!, label: {
                                Text(affiliateLink)
                                    .font(.subheadline)
                                    .opacity(0.8)
                            })
                            .padding(10)
                            .background()
                            .cornerRadius(10)
                            Spacer()
                            Menu {
                                Button {
                                   showAlert = true
                                } label: {
                                    Label("Report Issue", systemImage: "exclamationmark.circle")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .padding(20)
                            }
                           
                        }
                   
                    }
                   
                    Divider()
                }
                
               Spacer()
           
                if !promoCode.isEmpty {
                    HStack {
                      PromoCode(promoCode: promoCode, copied: $copied, degrees: $degrees)
                        Spacer()
                    }
                
                }
                
               Spacer()
                
            }
        }
        .environment(\.colorScheme, .dark)

        .task {
            //Check is offer is favorited
            guard let sponsor = matchingOffer?.sponsor else { return }
            guard let podcastTitle = podcast?.title else { return }
                    
            let fetchDescriptor = FetchDescriptor<SavedOffer>(predicate: #Predicate { offer in
                
                return  offer.sponsor.name == sponsor && offer.podcast.title  == podcastTitle

            })
            
            do {
                let offer = try modelContext.fetch(fetchDescriptor)
                
                if offer.isEmpty {
                    isFavorited = false
                } else {
                    isFavorited = true
                }
                                    
            } catch {
                print("Failed to set with error: \(error.localizedDescription)")
            }

        }
        .alert("Thanks for the feedback!", isPresented: $showGratitude) {
            
        } message: {
            Text("The developer has been notified.")
        }
        .alert("Report Issue", isPresented: $showAlert) {
            Button("Invalid Url") {
                sendEmail(reportType: .invalidURL, podcastTitle: podcast?.title ?? "", sponsorTitle: sponsor?.name ?? "")
                showGratitude = true
            }
            Button("Expired Promotion") {
                sendEmail(reportType: .expiredPromotion, podcastTitle: podcast?.title ?? "", sponsorTitle: sponsor?.name ?? "")
                showGratitude = true
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please let us know the problem.")
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
                    offer.sponsor.name == sponsorName && offer.podcast.title == podcastTitle
                })
                
            } catch {
                print("Failed to delete with error: \(error.localizedDescription)")
            }
    
        } else {
            isFavorited = true
            sensory.toggle()
            
//            let favoritedOffer = SavedOffer(podcast: .init(title: podcast?.title ?? "", image: podcast?.imageUrl ?? "", publisher: podcast?.publisher ?? ""), sponsor: matchingOffer?.sponsor ?? "", offer: sponsor?.offer ?? "", category: sponsor?.sponsorCategory?[0]?.name ?? "")
                    
            let favoritedOffer = SavedOffer(podcast: .init(title: podcast?.title ?? "", image: podcast?.imageUrl ?? "", publisher: podcast?.publisher ?? ""), sponsor: .init(name:  matchingOffer?.sponsor ?? "", category:sponsor?.sponsorCategory?[0]?.name ?? "", image: sponsor?.imageUrl ?? "" ), offer: sponsor?.offer ?? "")
            
            
            modelContext.insert(favoritedOffer)
        }
        
    }
    
  

}


//#Preview {
//    PodcastDetailSheet()
//}
