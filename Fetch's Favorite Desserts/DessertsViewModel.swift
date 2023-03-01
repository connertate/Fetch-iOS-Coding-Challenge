//
//  DessertsViewModel.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/28/23.
//

import Foundation

class DessertsViewModel: ObservableObject {
    
    @Published var desserts: [MealSummary] = []
    @Published var showNetworkErrorAlert = false
    @Published var meal: Meal? = nil
    private let networkController = NetworkController()
    
    init() {
        //Load the list of desserts on launch
        Task(priority: .high) {
            try await loadDesserts()
        }
    }
    
    /// Concurrently fetches, sorts, and stores mealSummary items in the desserts array
    func loadDesserts() async throws {
        let allDesserts = try await networkController.fetchDesserts()
        await MainActor.run {
            desserts = allDesserts.sorted { $0.strMeal < $1.strMeal }
        }
    }
    
    /// Concurrently load the full dessert item
    func loadDessert(withID id: String) async {
        Task(priority: .high) {
            do {
                let fullMeal = try await networkController.fetchDessert(withID: id)
                await MainActor.run {
                    meal = fullMeal
                }
            } catch {
                showNetworkErrorAlert = true
            }
        }
    }
    
}
