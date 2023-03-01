//
//  NetworkController.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 3/1/23.
//

import Foundation

class NetworkController {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    /// Async method to get the list of all desserts from the MealDB API
    /// - Returns: Array of meal summary objects to show in list
    func fetchDesserts() async throws -> [MealSummary] {
        let dessertListURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, response) = try await session.data(from: dessertListURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        let allDesserts = try decoder.decode(MealSummaries.self, from: data).meals
        return allDesserts.sorted { $0.strMeal < $1.strMeal }
    }
    
    /// Async method to access info for a specific dessert item
    /// - Parameter id: The dessert's ID 'idMeal' from the meal summary object
    /// - Returns: A meal object containing info about a the dessert
    func fetchDessert(withID id: String) async throws -> Meal {
        guard id != "" else { throw NetworkError.invalidMealID }
        let dessertBaseURLString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        let dessertURL = URL(string: dessertBaseURLString + id)!
        let (data, response) = try await session.data(from: dessertURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {throw NetworkError.invalidResponse}
        return try decoder.decode(Meals.self, from: data).meals.first!
    }
    
    //Possible errors for in networking
    enum NetworkError: Error {
        case invalidResponse
        case invalidMealID
    }

}

