//
//  NetworkController.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import Foundation

class NetworkController {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    let dessertListURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
    let dessertItemBaseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchDesserts() async -> [MealSummary] {
        print("Fetching data!")
        do {
            let (data, _) = try await session.data(from: dessertListURL)
            let desserts = try decoder.decode(Meals.self, from: data)
            
            for x in desserts.meals {
                print("\(x.strMeal)")
            }
            return desserts.meals
            
        } catch {
            print(error)
            return []
        }
    }
}
