//
//  Meal.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import Foundation


struct Meals: Codable {
    let meals: [MealSummary]
}

struct MealSummary: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
