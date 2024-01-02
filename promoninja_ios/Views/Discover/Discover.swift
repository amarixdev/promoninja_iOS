//
//  Discover.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/13/23.
//

import SwiftUI
import PromoninjaSchema


struct Discover: View {

    @Environment(\.dismiss) var dismiss
    @Binding var shouldScrollToTop: Bool
    private static let topId = "topIdHere"

    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    
//    var categories: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?] {
//        viewModel.categoryData ?? []
//    }
//    
    var categories: [GetSponsorCategoriesQuery.Data.GetSponsorCategory?]
    
    
    struct Sponsor: Hashable {
        let name: String
        let description: String
        let imageResource: ImageResource

        init(_ name: String, _ description: String, _ imageResource: ImageResource) {
            self.name = name
            self.description = description
            self.imageResource = imageResource
        }
    }
    
    let popularSponsors: Array<Sponsor> = [
        Sponsor("Athletic Greens", "The ultimate super greens powder. A blend of 91 vitamins, minerals & wholefood ingredients.", .ag1),
        Sponsor("TUSHY", "The modern and sustainable bidet company that offers an alternative to toilet paper.", .tushy)  ,
        Sponsor("Better Help", "Affordable, convenient online therapy when you need it from licensed, professional therapists.", .betterhelp)
//        Sponsor("Raycon", "Raycon, founded by singer Ray J, offers high-quality wireless earbuds for everyday use and workouts.", .raycon)
    ]

    @State private var popularIndex = 0
    @State private var t = ""
    
    let categoryImages: [String: (ImageResource, Color)] = [
        "Alcohol": (.alcoholB, .sponsorTheme),
        "Smoke & Vape": (.smokeB, .sponsorTheme),
        "Health & Wellness": ( .healthB, .sponsorTheme),
        "Digital Services": (.digitalServicesB, .sponsorTheme),
        "Food": (.foodB,.sponsorTheme),
        "Accessories": (.accessoriesB, .sponsorTheme),
        "Home": (.homeB, .sponsorTheme),
        "Outdoors": (.miscB, .sponsorTheme)
    ]
    
    
    func handleSwipe(dir: String) {
        if dir == "right" {
            if popularIndex == 2 {
               popularIndex = 0
            } else {
                popularIndex += 1
            }
        }
        
        if dir == "left" {
            if popularIndex == 0 {
                popularIndex = 2
            } else {
                popularIndex -= 1
            }
        }
        
    }
    
    func categoryPlaceholders () -> some View {
        ForEach(1..<9) { _ in
            
            ZStack {
                Rectangle()
                    .frame(width: 180, height: 100)
                    .foregroundStyle(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(color:.black, radius: 4, x: 3, y: 4)
            }
            .padding(.vertical, 2)
        }
    }
    
    
    
    var body: some View {
      
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [.sponsorTheme, .sponsorTheme.opacity(0.25), .black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                  
                        ScrollViewReader { reader in
                            ScrollView {

                                VStack {
                                        VStack {
                                            ZStack {
                                                HStack  {
                                                    Rectangle()
                                                         .frame(width: 290, height: 290)
                                                         .foregroundStyle(
                                                            LinearGradient(colors: [.black.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                                                         )
                                                         .shadow(color:.black, radius: 10)
                                                    Spacer()
                                                }
                                                .padding(.leading, 10)
                                                .frame(width: 400)
                                            
                                                    VStack {
                                                        HStack {
                                                            Text("Popular ")
                                                                .fontWeight(.bold)
                                                                .font(.subheadline)
                                                                .foregroundStyle(.white)
                                                            Spacer()
                                                        }
                                                        .frame(width: 350)
                                                      
                                                        Spacer()
                                                    }
                                                    .frame(height: 220)
                                                                           
                                                    Spacer()
                                                HStack {
                                                    Image(popularSponsors[popularIndex].imageResource)
                                                        .resizable()
                                                        .frame(width: 330, height: 190)
                                                        .shadow(color: .black, radius: 10)
                                                        .padding(.top, 40)
                                                        .animation(.bouncy, value: popularIndex)
                                                        .gesture (
                                                            DragGesture()
                                                                
                                                                .onEnded { value in
                                                                                       if value.translation.width > 50 {
                                                                                           handleSwipe(dir: "right")
                                                                                       } else if value.translation.width < -50 {
                                                                                           handleSwipe(dir: "left")
                                                                                       }
                                                                                   }
                                                        )
                                                    Spacer()
                                                }
                                                .frame(width: 50, height: 200)
                                                

                                            }
                                        }

                                        NavigationLink(value: popularSponsors[popularIndex]){
                                            VStack(alignment:.leading)  {
                                                HStack {
                                                    Text("\(popularSponsors[popularIndex].name)")
                                                        .font(.headline)
                                                        .fontWeight(.medium)
                                                        .animation(.none, value: popularIndex)
                                                    Image(systemName: "chevron.right")
                                                        .opacity(0.8)
                                                }
                                               
                                                Text(popularSponsors[popularIndex].description)
                                                    .opacity(0.8)
                                                    .font(.footnote)
                                                    .multilineTextAlignment(.leading)
                                                
                                                
                                            }
                                        }
                                        .padding()
                                      
                                      
                                        VStack(alignment:.leading) {
                                                Text("Shop Categories")
                                            .padding(.horizontal, 5)
                                            .padding(.bottom, 10)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .opacity(0.8)
                                                                      
                                            LazyVGrid(columns: [GridItem(.flexible(minimum: 100)), GridItem(.flexible(minimum: 100))], spacing: 10) {
                                                
                                                if categories.isEmpty {
                                                    categoryPlaceholders()
                                                } else
                                                
                                                {
                                                    ForEach(categories, id: \.self) { category in
                                                        NavigationLink(value: category){
                                                            
                                                            
                                                            ZStack {
                                                                Rectangle()
                                                                    .frame(width: 180, height: 100)
                                                                    .foregroundStyle(.ultraThinMaterial)
                                                                    .cornerRadius(10)
                                                                    .shadow(color:.black, radius: 4, x: 3, y: 4)
                                                                    
                                                                
                                                                HStack {
                                                                    VStack {
                                                                        Text(category?.name ?? "")
                                                                            .font(.system(size: 12))
                                                                            .fontWeight(.semibold)
                                                                            .multilineTextAlignment(.leading)
                                                                            
                                                    
                                                                            .lineLimit(category?.name == "Accessories" ? 1 :  2)
                                                                        Spacer()
                                                                    }
                                                                    .frame(width: 100, alignment:.leading)
                                                                    .padding(.top, 10)
                                                                    .padding(.leading, 20)
                                                                    
                                                                       
                                                                    Spacer()
                                                                    
                                                                    Image(categoryImages[category!.name]?.0 ?? .accessories)
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 70, height: 70)
                                                                        .cornerRadius(5)
                                                                        .rotationEffect(Angle(degrees: 340))
                                                                        .transformEffect(CGAffineTransform(translationX: 20, y: 20))
                                                                        .shadow(color:.black, radius: 4, x: 2, y: 4)
                                                                      
                                                                      
                                                                        
                                                                    
                                                                }
                                                                .frame(width: 180, height: 100)
                                                               
                                                                .cornerRadius(10)
                                                               
                                                                .clipped()
                                                               
                                                              
                                                            }
                                                            .padding(.vertical, 2)
                                                           
                                                     
                                                            

                                                    
                                                        }
                                                      
                                                            
                                                        
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }
                                        .padding(.top, 20)
                                        .padding(.horizontal,10)

                                    }
                                    .id(Self.topId)
                                
                             
                     
                                .padding(.vertical, 30)
                            }
                            .onChange(of: shouldScrollToTop) {
                                               withAnimation {
                                                   reader.scrollTo(Self.topId, anchor: .top)
                                               }
                                setTimeout(0.25) {
                                    shouldScrollToTop = false
                                }
                                           }
                        }
                    
             
                    
                    
                }
              
                .onReceive(timer, perform: { _ in
                    handleSwipe(dir: "right")
                })
                .navigationTitle("Discover More")
                .id(Self.topId)
                .navigationDestination(for: GetPodcastCategoriesQuery.Data.GetPodcastCategory.Podcast.self) { podcast in
                    PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
                }
                
                .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.Podcast.self) { podcast in
                            PodcastView(title: GraphQLNullable(stringLiteral:podcast.title ) )
                        }
            
                .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.self) { podcast in
                    PodcastView(title: GraphQLNullable(stringLiteral: podcast.title))
                        }
                
                .navigationDestination(for: GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor.self) { sponsor in
                    if let name = sponsor.name {
                        SponsorView(name: name )
                    }
                }
             
                .navigationDestination(for: GetPodcastQuery.Data.GetPodcast.Sponsor.self) { sponsor in
                    if let name = sponsor.name {
                        SponsorView(name: name)
                    }
                           
                        }
            
                .navigationDestination(for: GetSponsorQuery.Data.GetSponsor.self) { sponsor in
                    if let name = sponsor.name {
                        SponsorView(name: name)
                    }
                                           
                        }
       
                .navigationDestination(for: Sponsor.self) { sponsor in
                    
                    SponsorView(name: sponsor.name)
                }

    }
}

//#Preview {
//    NavigationStack {
//        Discover(shouldScrollToTop: .constant(false))
//           
//    }
//    .preferredColorScheme(.dark)
//   
//    
//}
