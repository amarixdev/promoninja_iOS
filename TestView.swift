//
//  TestView.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/3/23.
//


import SwiftUI
import Combine

struct Restaurant: Hashable, Identifiable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption: String {
    case American, Italian, Japanese
}



final class RestaurantManager {
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "BurgerShack", cuisine: .American),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .Italian),
            Restaurant(id: "3", title: "Sushi Heavab", cuisine: .Japanese),
            Restaurant(id: "4", title: "QuickeMart", cuisine: .American)
        ]
    }
}

@MainActor
final class SearchableViewModel: ObservableObject {
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []

    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    let manager = RestaurantManager()
    
    init() {
        addSubscribers()
    }
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    private func addSubscribers () {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterRestaurants(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    
    private func filterRestaurants (searchText: String) {
        guard !searchText.isEmpty else {
            filteredRestaurants = []
            return
        }
        
        let search = searchText.lowercased()
        
        filteredRestaurants = allRestaurants.filter({ restaurant in
            let titleContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            let cuisineContainsSearch = restaurant.title.lowercased().contains(search)
            
            return titleContainsSearch || cuisineContainsSearch

        })
    }
    
    func loadAllRestaurants () async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
        } catch {
            print(error)
        }
    }

}


struct SearchableView: View {
    @StateObject var viewModel = SearchableViewModel()
    
   
    
    var body: some View {
        ScrollView() {
            VStack(alignment:.leading, spacing: 20) {
                ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants) {
                    restaurantRow(restaurant: $0)
                }
            }
        }
       
        .navigationTitle("Restaurant")
        .task {
            await viewModel.loadAllRestaurants()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: "Search Restaurants" )
        
    }
    
    private func restaurantRow (restaurant: Restaurant) -> some View {
        VStack(alignment:.leading, spacing:20) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.black.opacity(0.05))
    }
}


#Preview {
    NavigationStack {
        SearchableView()

    }
}
