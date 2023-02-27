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
                NavigationLink(destination: Text("A")) {
                    Text(dessert.strMeal)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
