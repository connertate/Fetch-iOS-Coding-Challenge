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
            let desserts = try decoder.decode(MealSummaries.self, from: data)
            
            for x in desserts.meals {
                print("\(x.strMeal)")
            }
            return desserts.meals
            
        } catch {
            print(error)
            return []
        }
    }
    
    func fetchDessert(withID id: String) async -> Meal? {
//        print("Fetching single dessert with URL:")
        
        do {
            let dessertURL = URL(string: dessertItemBaseURL + id)!
            print(dessertItemBaseURL + id)
            let (data, _) = try await session.data(from: dessertURL)
//            print(String(data: data, encoding: .utf8))
            let desserts = try decoder.decode(Meals.self, from: data)
            
//            for x in desserts.meals {
//                print("\(x.strInstructions)")
//            }
            return desserts.meals.first ?? nil
            
        } catch {
            print(error)
            return nil
        }
    }
}
