//
//  ContentView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertListView: View {
    
    var body: some View {
        NavigationView {
            List {
                Text("Cake")
                Text("Brownie")
                Text("Cookies")
                Text("s")
            }
            .navigationTitle("Desserts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
    }
}
