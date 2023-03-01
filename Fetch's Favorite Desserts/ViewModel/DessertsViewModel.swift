//
//  DessertsViewModel.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/28/23.
//

import Foundation

class DessertsViewModel: ObservableObject {
    
    private let networkController = NetworkController()
    
    @Published var desserts: [MealSummary] = []
    @Published var meal: Meal? = nil
    @Published var showNetworkErrorAlert = false
    
    init() {
        //Load the list of desserts on launch
        Task(priority: .high) {
            await fetchDesserts()
        }
    }
    
    /// Populates desserts array with data from network controller
    func fetchDesserts() async {
        do {
            let allDesserts = try await networkController.fetchDesserts()
            await MainActor.run { desserts = allDesserts }
        } catch {
            await MainActor.run { showNetworkErrorAlert = true }
        }
    }
    
    /// Stores individual dessert from network controller
    /// - Parameter id: The dessert's ID 'idMeal' from the meal summary object
    func fetchDessert(withID id: String) async {
        do {
            let fullMeal = try await networkController.fetchDessert(withID: id)
            await MainActor.run { meal = fullMeal }
        } catch {
            await MainActor.run { showNetworkErrorAlert = true }
        }
    }
}
