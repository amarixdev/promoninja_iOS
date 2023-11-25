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
    
    @State var dataLoaded = false

    
        var body: some View {
            if !dataLoaded {
                ZStack {
                    Rectangle().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .foregroundColor(.black)
                        .ignoresSafeArea()
                    Text("Loading...")
                }
                .onChange(of: sponsor) {
                    dataLoaded = true
                }
                
                   
            } else {
           
                    ZStack {
                        
                        LinearGradient(gradient: Gradient(colors: [.black, .black, Color.black]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                            
                       ScrollView {
                            VStack {
                       
                                    AsyncImage(
                                        url: URL(string: sponsor?.imageUrl ?? "")
                                    ) { phase in
                                        
                                        if let image = phase.image {
                                            image.resizable()
                                                 .aspectRatio(contentMode: .fit)
                                                 .frame(width: 180, height: 180)
                                                 .cornerRadius(20)
                                        } else {
                                            Rectangle()
                                                .frame(width: 180, height: 180)
                                                .cornerRadius(20)
                                                .foregroundStyle(Color(.systemGray5).gradient)
                                        }
                                       
                                          
                                    }
                                        }
                                    
                              
                                .padding(.bottom, 15)
                           
                           if let url = sponsor?.url {
                               Text((url).truncated(maxLength: 35))
                                        .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.gray)
                           }
                           
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
                               
                                //Podcasts
                                PodcastListView(sponsor: sponsor)
                                                        
                                Spacer()
                            }
                        }
                  
                        .padding()
                        .navigationTitle(sponsor?.name ?? "")
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .tint(.white)
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

#Preview {
    SponsorView(name: "Tushy")
        .preferredColorScheme(.dark)
}
