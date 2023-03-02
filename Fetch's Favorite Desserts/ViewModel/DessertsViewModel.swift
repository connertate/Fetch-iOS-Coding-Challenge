//
//  DessertsViewModel.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/28/23.
//

import Foundation

class DessertsViewModel: ObservableObject {
    
    private let networkController = NetworkController()
    
    //Array of all dessert items
    @Published var desserts: [MealSummary] = []
    //Optional to hold loaded data for user selected dessert
    @Published var dessert: Meal? = nil
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
            await MainActor.run {  desserts = allDesserts }
        } catch {
            await MainActor.run { showNetworkErrorAlert = true }
        }
    }
    
    /// Stores individual dessert from network controller
    /// - Parameter id: The dessert's ID 'idMeal' from the meal summary object
    func fetchDessert(withID id: String) async {
        do {
            let fullMeal = try await networkController.fetchDessert(withID: id)
            await MainActor.run { dessert = fullMeal }
        } catch {
            await MainActor.run { showNetworkErrorAlert = true }
        }
    }
}
