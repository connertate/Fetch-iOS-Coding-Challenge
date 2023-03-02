//
//  ContentView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertListView: View {
    @EnvironmentObject var vm: DessertsViewModel

    var body: some View {
        NavigationView {
            if(vm.desserts.count == 0) {
                ProgressView()
            } else {
                List(vm.desserts, id: \.self) { dessert in
                    NavigationLink(destination: MealDetailView(mealSummary: dessert)) {
                        Text(dessert.strMeal)
                    }
                }
                .navigationTitle("Desserts")
            }
        }
        //Alert error to warn user of network errors
        .alert("Trouble loading data, please check your connection", isPresented: $vm.showNetworkErrorAlert) {
            Button("Ok", role: .cancel) {
                vm.showNetworkErrorAlert = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
