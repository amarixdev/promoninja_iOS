//
//  SponsorView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/23/23.
//

import SwiftUI
import PromoninjaSchema

 


struct SponsorView: View {
    @StateObject var viewModel: SponsorViewModel
    var name: String
    
    init(name: String ) {
        self.name = name
        self._viewModel = StateObject(wrappedValue: SponsorViewModel(name: name))
    }
    
    var sponsor: GetSponsorQuery.Data.GetSponsor? {
        viewModel.sponsorData
    }

    
//    @State private var path = NavigationPath()

    
        var body: some View {
            if sponsor?.name == nil {
                ZStack {
                    Rectangle().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .foregroundColor(.black)
                        .ignoresSafeArea()
                    Text("Loading...")
                }
                   
            } else {
           
                    ZStack {
                        
                        LinearGradient(gradient: Gradient(colors: [.black, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            
                       ScrollView {
                            VStack {
                                AsyncImage(
                                    url: URL(string: sponsor?.imageUrl ?? "")
                                ) { image in
                                    image.image?.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 180, height: 180)
                                        .cornerRadius(20)
                                      
                                }
                                .padding(.bottom, 15)
                          
                                Text((sponsor?.url)!)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.gray)
                                
                                
                                //Buttons
                                HStack {
                                    Button {
                                      
                                    } label: {
                                        Text(sponsor?.sponsorCategory?[0]?.name ?? "")
                                            .foregroundStyle(.white)
                                            .font(.subheadline.bold())
                                          
                                    }
                                    .buttonStyle(.bordered)
                                    Button {
                                      
                                    } label: {
                                        Text("Share")
                                            .foregroundStyle(.white)
                                            .font(.subheadline.bold())
                                          
                                    }
                                    .buttonStyle(.bordered)
                              
                                }
                                .padding()
                               
                                //Sponsors
                      
                                VStack(spacing: 10) {
                                    ForEach(sponsor?.podcast ?? [], id: \.self) {
                                        podcast in
                                        
                                        NavigationLink(value: podcast) {
                                                    HStack(spacing: 30) {
                                                        AsyncImage(url: URL(string: podcast?.imageUrl ?? "")) {
                                                            image in
                                                            image.image?.resizable()
                                                                .frame(width: 50, height: 50)
                                                                .cornerRadius(10)
                                                        
                                                        }
                                                        
                                                        VStack(alignment:.leading) {
                                                            if let podcast = podcast {
                                                                Text(podcast.title)
                                                                    .font(.caption.bold())
                                                                    .foregroundStyle(.white)
                                                                
                                                                Text(podcast.publisher ?? "")
                                                                    .font(.caption.bold())
                                                                    .foregroundStyle(.gray)
                                                            }
                                                        }
                                                          
                                                        Spacer()
                                                    }
                                                }
//                                        .onTapGesture {
//                                            path.append(podcast)
//                                        }
//                                               
                                                Divider()
                                            
                                             
                                        }
                                    }
                                    .padding()
                             
                                Spacer()
                            }
                        }
                  
                        .padding()
                        .navigationTitle(sponsor?.name ?? "")
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbarTitleDisplayMode(.inline)
                        .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.Podcast.self) { podcast in
                            PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
                        }
                        .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.Sponsor.self) { sponsor in
                            SponsorView(name: sponsor.name!)
//                            Text("Clicked")
                        }

                        
                    }
                   
                
                
                
            }
     
        }
}

#Preview {
    SponsorView(name: "Tushy")
        .preferredColorScheme(.dark)
}
