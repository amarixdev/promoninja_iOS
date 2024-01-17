//
//  CategoryView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/28/23.
//

import SwiftUI
import PromoninjaSchema
import NukeUI

struct CategoryView: View {
    let category: GetSponsorCategoriesQuery.Data.GetSponsorCategory
//    @State private var currentCategory:  GetSponsorCategoriesQuery.Data.GetSponsorCategory
    @State private var categoryTapped = false
    @Binding var selectedCategoryTitle: String
    
    @State private var onChangeToggle = false
    @StateObject var viewModel = SponsorCategoriesViewModel()
    
    var currentCategory: GetSponsorCategoriesQuery.Data.GetSponsorCategory? {
        viewModel.categoryData?.filter { category in
            category?.name == selectedCategoryTitle
        }[0]
    }
    

    @State private var buttonID = String()
    
    
    var sortedSponsors: [GetSponsorCategoriesQuery.Data.GetSponsorCategory.Sponsor?]? {
        currentCategory?.sponsor?.sorted(by: { a, b in
            a?.name ?? "" < b?.name ?? ""
        })
    }
    
    
    var body: some View {
        ZStack {
            GradientView()
                        
            VStack {
                HStack {
                    ScrollViewReader { reader in
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(viewModel.categoryData ?? [], id: \.self) { category in
                                    if let name = category?.name {
                                        Button(name == "Outdoors" ? "Misc" : name) {
                                            selectedCategoryTitle = name
                                            categoryTapped = true
                                            setTimeout(0.2) {
                                                categoryTapped = false
                                            }
                                            buttonID = name
                                        }
                                        .fontWeight(.medium)
                                        .font(.subheadline)
                                        .buttonStyle(.borderedProminent)
                                        .tint(selectedCategoryTitle == name ? .logo : .sponsorTheme)
                                        .foregroundStyle( .white.opacity(0.8))
                                        .animation(.none, value: selectedCategoryTitle == name)
                                        .scaleEffect(selectedCategoryTitle == name && categoryTapped ? 0.9 : 1.0)
                                        .animation(.bouncy, value: categoryTapped)
                                        .id(selectedCategoryTitle == name ? name : nil)
                                        
                                    }
                                }
                            }
                        }
                      
                        .scrollIndicators(.hidden)
                        .onChange(of: selectedCategoryTitle) {
                            withAnimation {
                                    reader.scrollTo(buttonID, anchor: .center)
                            }
                        }
                        
                        
                        .onChange(of: onChangeToggle) {
                                withAnimation {
                                        withAnimation {
                                            reader.scrollTo(buttonID, anchor: .center)
                                        }
                            }
                           
                        }
                        .sensoryFeedback(.selection, trigger: selectedCategoryTitle)
                    }
                }
                .padding([.horizontal, .bottom])
                
              Divider()
                    
                
                ScrollView {

                    
                    VStack(alignment: .leading, spacing: 10)
                     {
                         if let sponsors = sortedSponsors {
                            ForEach(sponsors, id:\.self) { sponsor in
                                if let sponsor = sponsor {
                                    
                                    NavigationLink(value:sponsor){
                                        HStack(spacing: 25) {
                                            if let imageUrl = sponsor.imageUrl {
                                                LazyImage(url: URL(string: imageUrl)!, transaction: Transaction(animation: .bouncy)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 70, height: 70)
                                                            .cornerRadius(10)
                                                            .shadow(radius: 10)
                                                    }
                                                    else {
                                                        Placeholder(frameSize: 70, imgSize: 35, icon: .sponsor)
                                                    }
                                                    
                                                }
                                            }
                                            VStack(alignment:.leading) {
                                                Text(sponsor.name ?? "")
                                                    .font(.title2)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundStyle(.white)
                                                    .fontWeight(.semibold)
                                                Text(sponsor.summary ?? "")
                                                    .font(.caption)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(2)
                                                    .foregroundStyle(.white)
                                                    .opacity(0.8)
                                             
                                                   
                                            }
                                                Spacer()
                                                    Image(systemName: "chevron.right")
                                                            .foregroundStyle(.white.opacity(0.5))
                                        }
                                    }
                                    .padding()
                                    Divider()
                                }
                            }
                        }
                       
                    }
                }
            }
            
            .padding(.top, 40)
        }
        .onAppear() {
            buttonID = selectedCategoryTitle
            setTimeout(0.25) {
                onChangeToggle.toggle()
            }
        }
      
        .navigationTitle(currentCategory?.name == "Outdoors" ? "Misc" : currentCategory?.name  ?? "")
        .toolbarStyle(inline: true)
    }
}


