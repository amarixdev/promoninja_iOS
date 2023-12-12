//
//  PopularCreators.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/6/23.
//

import SwiftUI
import PromoninjaSchema

struct PopularCreators: View {
   @Binding var currentCategory: String?
    @State private var selectedCreator = Creator(fullName: "", image: .logo, podcasts: [], summary: "")
    
    var creators: [Creator] {
        getCreators(category: currentCategory ?? "")
    }
    @State private var creatorData: GetPodcastQuery.Data.GetPodcast?
    @State private var showSelection = false
    @State private var tapped = false

    @GestureState private var podcastTapped = false
    
    
    var body: some View {
        HStack {
            Text("Popular Creators")
                .font(.headline)
 
            Spacer()
        }
        .padding()
        
        ScrollView(.horizontal) {
                                         HStack(spacing: 20) {
                                             ForEach(creators, id: \.self) { creator in
   
                                                     VStack {
                                                         Image(creator.image)
   
                                                             .resizable()
                                                             .scaledToFill()
                                                             .frame(width: 100, height: 100)
                                                             .clipShape(Circle())
                                                             .shadow(color: .black, radius: 4, x:-2, y:3)
                                                           

                                                         Text(creator.fullName)
                                                             .font(.caption)
                                                             .fontWeight(.semibold)
                                                             .foregroundStyle(.white)
   
                                                     }
                                                 
   
                                                 .onTapGesture {
                                                     selectedCreator = creator
                                                     getPodcastData(title: GraphQLNullable(stringLiteral: creator.podcasts[0]))
                                                     showSelection = true
   
                                                 }

                                                .sheet(isPresented: $showSelection) {
                                                     ZStack {
                                                         LinearGradient(colors: [Color(.sponsorTheme).opacity(0.85), .black.opacity(0.95), .black], startPoint: .top, endPoint: .bottom)
                                                             .ignoresSafeArea(.all)
   
                                                         PodcastSelectionSheet(creator: $selectedCreator )
                                                             .presentationDetents([.large])
   
                                                     }
   
                                                 }
   
                                             }
                                         }
   
                                     }
                                     .scrollIndicators(.hidden)
                                     .zIndex(10)
                                    

        Divider ()
            .padding()
    }
    
    func getPodcastData (title: GraphQLNullable<String>) {
        Network.shared.apollo.fetch(query: GetPodcastQuery(input: PodcastInput(podcast: title))) { result in
            guard let data = try? result.get().data else { return }
           
            if let fetchedData = data.getPodcast {
                DispatchQueue.main.async {
                    creatorData.self = fetchedData
                }
            }
        }
    }
}

#Preview {

    PopularCreators( currentCategory: .constant("comedy"))
        .preferredColorScheme(.dark)
}
