//
//  BrokenLinks_Test.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 1/16/24.
//

import Foundation
import SwiftUI
import PromoninjaSchema


struct LinkTest: View {
   @State private  var podcasts = [GetPodcastsQuery.Data.GetPodcast?]()
    @State private  var sponsors = [GetSponsorsQuery.Data.GetSponsor?]()
    @State private var invalidLinks = [String]()
    @State private var privacyLinks = [String]()
    @State private var loading = false
    var sponsorLinks: [String] {
        sponsors.map { sponsor in
            formatURL(sponsor?.url ?? "")
        }
        
      
    }

    var podcastLinks: [String] {
        let allUrls = podcasts.compactMap { podcast in
           return  podcast?.offer.map { offer in
               return offer.map { offer in
                   formatURL(offer?.url ?? "")
                }
            }
        }
        
        return   Array(Set(allUrls.flatMap{$0}))

    }
    
    
    
    func formatURL (_ urlString: String) -> String {
        return "https://www.\(urlString)"
    }
    
    
    let group = DispatchGroup()
    
    
    func isValidURL (urls: [String]) {
        
        let privacyError = "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection."
        
        urls.forEach { urlString in
            guard let url = URL(string: urlString) else {
                print("Invalid URL format: \(urlString)")
                invalidLinks.append(urlString)
                return
            }

            group.enter()
            loading = true
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    if error.localizedDescription != privacyError {
                        
                        invalidLinks.append(urlString)
                        
                        print("URL is invalid or inaccessible: \(urlString), Error: \(error.localizedDescription)")
                        
                    } else if error.localizedDescription  == privacyError {
                        privacyLinks.append(urlString)
                    }
                   
                    
                } else if let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode {
                    print("URL is valid: \(urlString)")
                } else {
                    print("URL is invalid or inaccessible: \(urlString)")
                    invalidLinks.append(urlString)
                }
                group.leave()
            }
            task.resume()
        }
        
        group.notify(queue: DispatchQueue.main) {
                loading = false
                   print("Finished")
                }
        
        
        
        
    }
    
    
    
    
        var body: some View {
            
            ScrollView {
                
                VStack {
                    Text("Total Podcasts: \(podcasts.count)")
                    Text("Total Sponsors: \(sponsors.count)")
                }
                .fontWeight(.bold)
                  
                
                Rectangle()
                    .frame(width: 500, height: 0.25).foregroundStyle(.secondary)
                    .padding()
                
        
                VStack(spacing: 20) {
                    HStack {
                        Text("Sponsor Link Test (\(sponsorLinks.count)) ")
                            .font(.headline)
                        Button("Run") {
                            isValidURL(urls: sponsorLinks)
                        }
                        .buttonStyle(.bordered)
                    }

             
                    HStack {
                        Text("Podcast Link Test (\(podcastLinks.count)) ")
                            .font(.headline)
                        Button("Run") {
                            isValidURL(urls: podcastLinks)
                        }
                        .buttonStyle(.bordered)
                    }
                }
        
                
                
                Rectangle()
                    .frame(width: 500, height: 0.25).foregroundStyle(.secondary)
                    .padding()
                
                LinkAsset(linkType: .broken)
                LinkAsset(linkType: .privacy)
                
                
            }
            .font(.title3)

                .task {
                    getPodcastsData()
                    getSponsorsData()
                    
                }
    }
    
    enum LinkTypes: String {
        case privacy
        case broken
        
    }
    
    func LinkAsset(linkType: LinkTypes) -> some View {
        let invalidLinks = linkType == .broken ? invalidLinks : privacyLinks
        
       return VStack {
            Text("\(linkType.rawValue.capitalized) Links")
                .font(.title.bold())
                .padding()

            if loading {
                ProgressView()
            }
            ForEach(invalidLinks, id:\.self) {
                Text($0)
                    .foregroundStyle(.secondary)
                    .font(.headline)
                
            }
            
            Text("Found")  + Text(" \(invalidLinks.count)").bold().foregroundStyle(linkType == .broken ? .red : .orange).font(.title) + Text(" \(linkType.rawValue) Links")
        }
        .padding()
        


    }
    
    
    private func getPodcastsData () {
           Network.shared.apollo.fetch(query: GetPodcastsQuery()) { result in
               guard let data = try? result.get().data else { return }
               if let podcastsData = data.getPodcasts {
                       self.podcasts = podcastsData
                   
               }
           }
       }
    
    private func getSponsorsData () {
        Network.shared.apollo.fetch(query: GetSponsorsQuery(input: GraphQLNullable (Pagination(offset: 0, pageSize: 0, offerPage: false, path: false)))) { result in
               guard let data = try? result.get().data else { return }
               
            if let sponsorsData = data.getSponsors {
                       self.sponsors = sponsorsData
                
               }
           }
       }
    
    
    
       
}



#Preview {
    LinkTest()
        .preferredColorScheme(.dark)
}
