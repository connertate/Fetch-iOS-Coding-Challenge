//
//  Fetch_s_Favorite_DessertsApp.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

//App icon from: https://unsplash.com/photos/q54Oxq44MZs

import SwiftUI

@main
struct Fetch_s_Favorite_DessertsApp: App {
    //Create viewModel to be injected into the environment
    @StateObject var vm = DessertsViewModel()
    
    var body: some Scene {
        WindowGroup {
            DessertListView()
                .environmentObject(vm)
        }
    }
}
