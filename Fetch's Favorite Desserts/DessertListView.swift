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
    @State var showNetworkErrorAlert = false
    
    
    /// Concurrently fetches, sorts, and stores mealSummary items in the desserts array 
    func loadDesserts() {
        Task(priority: .high) {
            do {
                let allDesserts = try await networkController.fetchDesserts()
                desserts = allDesserts.sorted { $0.strMeal < $1.strMeal }
            } catch {
                showNetworkErrorAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(desserts, id: \.self) { dessert in
                NavigationLink(destination: DessertDetailView(mealSummary: dessert)) {
                    Text(dessert.strMeal)
                }
            }
            .navigationTitle("Desserts")
        }
        //Load desserts when app is launched
        .onAppear{
            loadDesserts()
        }
        //Alert error to warn user about network issues
        .alert("Trouble connecting to the internet, please check your connection", isPresented: $showNetworkErrorAlert) {
            Button("Ok", role: .cancel) {
                showNetworkErrorAlert = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
