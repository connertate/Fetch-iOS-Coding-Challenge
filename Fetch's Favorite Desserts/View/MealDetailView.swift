//
//  DessertDetailView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

//View to display more info for a selected dessert
struct MealDetailView: View {
    
    @EnvironmentObject var vm: DessertsViewModel
    //Meal summary item is passed to this view so we can instantly display title
    var mealSummary: MealSummary
    
    var body: some View {
        Form {
            MealTitleView(dessert: mealSummary)
            
            Section(header: Text("Ingredients")) {
                IngredientsView()
            }
            
            Section(header: Text("Directions")) {
                Text(vm.dessert?.strInstructions ?? "")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        //Load dessert info when view is presented
        .onAppear{
            Task(priority: .high) {
                await vm.fetchDessert(withID: mealSummary.idMeal)
            }
        }
        //Alert error to warn user about network issues
        .alert("Trouble loading data, please check your connection", isPresented: $vm.showNetworkErrorAlert) {
            Button("Ok", role: .cancel) { vm.showNetworkErrorAlert = false }
        }
    }
}

//View to show dessert image and title
struct MealTitleView: View {
    let dessert: MealSummary
    
    var body: some View {
        VStack {
            Text(dessert.strMeal)
                .font(.title2.weight(.semibold))
                .padding(.top, 10)
            
            AsyncImage(
                url: URL(string: dessert.strMealThumb),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(Constants.cornerRadius)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            Spacer()
        }
    }
}

//Lists all ingredients, verbose solution but simple
struct IngredientsView: View {
    
    @EnvironmentObject var vm: DessertsViewModel
    
    var body: some View {
        Group {
            IngredientItemView(ingredient: vm.dessert?.strIngredient1, measure: vm.dessert?.strMeasure1)
            IngredientItemView(ingredient: vm.dessert?.strIngredient2, measure: vm.dessert?.strMeasure2)
            IngredientItemView(ingredient: vm.dessert?.strIngredient3, measure: vm.dessert?.strMeasure3)
            IngredientItemView(ingredient: vm.dessert?.strIngredient4, measure: vm.dessert?.strMeasure4)
            IngredientItemView(ingredient: vm.dessert?.strIngredient5, measure: vm.dessert?.strMeasure5)
            IngredientItemView(ingredient: vm.dessert?.strIngredient6, measure: vm.dessert?.strMeasure6)
            IngredientItemView(ingredient: vm.dessert?.strIngredient7, measure: vm.dessert?.strMeasure7)
            IngredientItemView(ingredient: vm.dessert?.strIngredient8, measure: vm.dessert?.strMeasure8)
            IngredientItemView(ingredient: vm.dessert?.strIngredient9, measure: vm.dessert?.strMeasure9)
            IngredientItemView(ingredient: vm.dessert?.strIngredient10, measure: vm.dessert?.strMeasure10)
        }
        
        Group {
            IngredientItemView(ingredient: vm.dessert?.strIngredient11, measure: vm.dessert?.strMeasure11)
            IngredientItemView(ingredient: vm.dessert?.strIngredient12, measure: vm.dessert?.strMeasure12)
            IngredientItemView(ingredient: vm.dessert?.strIngredient13, measure: vm.dessert?.strMeasure13)
            IngredientItemView(ingredient: vm.dessert?.strIngredient14, measure: vm.dessert?.strMeasure14)
            IngredientItemView(ingredient: vm.dessert?.strIngredient15, measure: vm.dessert?.strMeasure15)
            IngredientItemView(ingredient: vm.dessert?.strIngredient16, measure: vm.dessert?.strMeasure16)
            IngredientItemView(ingredient: vm.dessert?.strIngredient17, measure: vm.dessert?.strMeasure17)
            IngredientItemView(ingredient: vm.dessert?.strIngredient18, measure: vm.dessert?.strMeasure18)
            IngredientItemView(ingredient: vm.dessert?.strIngredient19, measure: vm.dessert?.strMeasure19)
            IngredientItemView(ingredient: vm.dessert?.strIngredient20, measure: vm.dessert?.strMeasure20)
        }
    }
}

//View for individual ingredient and measurement, returns and emptyView if there is no respective ingredient
struct IngredientItemView: View {
    let ingredient: String?
    let measure: String?
    
    var body: some View {
        if(ingredient != nil && !ingredient!.isEmpty) {
            HStack {
                Text(ingredient ?? "")
                Spacer()
                Text(measure ?? "")
            }
        } else {
            EmptyView()
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealSummary: MealSummary(strMeal: "Pancakes", strMealThumb: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg", idMeal: "52855"))
    }
}
