//
//  NetworkController.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import Foundation

class NetworkController {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    /// Async method to get the list of all desserts from the MealDB API
    /// - Returns: Array of meal summary objects to show in list
    func fetchDesserts() async throws -> [MealSummary] {
        //Build URL
        let dessertListURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        //Fetch data from API
        let (data, response) = try await session.data(from: dessertListURL)
        //Validate response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        //Decode JSON to objects
        return try decoder.decode(MealSummaries.self, from: data).meals
    }
    
    /// Async method to access info for a specific dessert item
    /// - Parameter id: The dessert's ID 'idMeal' from the meal summary object
    /// - Returns: A meal object containing info about a the dessert
    func fetchDessert(withID id: String) async throws -> Meal {
        //Build URL
        let dessertBaseURLString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        let dessertURL = URL(string: dessertBaseURLString + id)!
        //Fetch data from API
        let (data, response) = try await session.data(from: dessertURL)
        //Validate response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {throw NetworkError.invalidResponse}
        //Decode JSON to object and return the one meal from the array
        return try decoder.decode(Meals.self, from: data).meals.first!
    }
}

extension NetworkController {
    //Possible errors for in networking
    enum NetworkError: Error {
        case invalidResponse
    }
}
