//
//  ContentView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertListView: View {
    @StateObject var vm = DessertsViewModel()

    var body: some View {
        NavigationView {
            List(vm.desserts, id: \.self) { dessert in
                NavigationLink(destination: DessertDetailView(mealSummary: dessert)) {
                    Text(dessert.strMeal)
                }
            }
            .navigationTitle("Desserts")
        }
        .environmentObject(vm)
        //Alert error to warn user about network issues
        .alert("Trouble connecting to the internet, please check your connection", isPresented: $vm.showNetworkErrorAlert) {
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
