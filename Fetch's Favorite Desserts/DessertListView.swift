//
//  ContentView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertListView: View {
    var networkController = NetworkController()
    @State var desserts: [MealSummary] = []
    
    var body: some View {
        NavigationView {
            List(desserts, id: \.self) { dessert in
                NavigationLink(destination: DessertDetailView(mealSummary: dessert)) {
                    ListCell(meal: dessert)
                }
            }
            .navigationTitle("Desserts")
        }
        .onAppear{
            Task {
                var allDesserts = await networkController.fetchDesserts()
                allDesserts.sort {
                    $0.strMeal < $1.strMeal
                }
                desserts = allDesserts
            }
        }
    }
}

struct ListCell: View {
    var meal: MealSummary
    
    var body: some View {
        HStack {
//            AsyncImage(
//                url: URL(string: meal.strMealThumb),
//                content: { image in
//                    image.resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 40, maxHeight: 40)
//                        .cornerRadius(50)
//                },
//                placeholder: {
//                    ProgressView()
//                }
//            )
            
            Text(meal.strMeal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
