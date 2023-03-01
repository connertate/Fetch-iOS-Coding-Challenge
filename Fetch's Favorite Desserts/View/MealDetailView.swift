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
    var mealSummary: MealSummary
    
    var body: some View {
        Form {
            MealTitleView(title: mealSummary.strMeal, imageURLString: mealSummary.strMealThumb)
            
            Section(header: Text("Ingredients")) {
                IngredientsView()
            }
            
            Section(header: Text("Directions")) {
                Text(vm.meal?.strInstructions ?? "")
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
    let title: String
    let imageURLString: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title2.weight(.semibold))
                .padding(.top, 10)
            
            AsyncImage(
                url: URL(string: imageURLString),
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

//Lists all ingredients, verbose solution but simple and easy
struct IngredientsView: View {
    
    @EnvironmentObject var vm: DessertsViewModel
    
    var body: some View {
        Group {
            IngredientItemView(ingredient: vm.meal?.strIngredient1, measure: vm.meal?.strMeasure1)
            IngredientItemView(ingredient: vm.meal?.strIngredient2, measure: vm.meal?.strMeasure2)
            IngredientItemView(ingredient: vm.meal?.strIngredient3, measure: vm.meal?.strMeasure3)
            IngredientItemView(ingredient: vm.meal?.strIngredient4, measure: vm.meal?.strMeasure4)
            IngredientItemView(ingredient: vm.meal?.strIngredient5, measure: vm.meal?.strMeasure5)
            IngredientItemView(ingredient: vm.meal?.strIngredient6, measure: vm.meal?.strMeasure6)
            IngredientItemView(ingredient: vm.meal?.strIngredient7, measure: vm.meal?.strMeasure7)
            IngredientItemView(ingredient: vm.meal?.strIngredient8, measure: vm.meal?.strMeasure8)
            IngredientItemView(ingredient: vm.meal?.strIngredient9, measure: vm.meal?.strMeasure9)
            IngredientItemView(ingredient: vm.meal?.strIngredient10, measure: vm.meal?.strMeasure10)
        }
        
        Group {
            IngredientItemView(ingredient: vm.meal?.strIngredient11, measure: vm.meal?.strMeasure11)
            IngredientItemView(ingredient: vm.meal?.strIngredient12, measure: vm.meal?.strMeasure12)
            IngredientItemView(ingredient: vm.meal?.strIngredient13, measure: vm.meal?.strMeasure13)
            IngredientItemView(ingredient: vm.meal?.strIngredient14, measure: vm.meal?.strMeasure14)
            IngredientItemView(ingredient: vm.meal?.strIngredient15, measure: vm.meal?.strMeasure15)
            IngredientItemView(ingredient: vm.meal?.strIngredient16, measure: vm.meal?.strMeasure16)
            IngredientItemView(ingredient: vm.meal?.strIngredient17, measure: vm.meal?.strMeasure17)
            IngredientItemView(ingredient: vm.meal?.strIngredient18, measure: vm.meal?.strMeasure18)
            IngredientItemView(ingredient: vm.meal?.strIngredient19, measure: vm.meal?.strMeasure19)
            IngredientItemView(ingredient: vm.meal?.strIngredient20, measure: vm.meal?.strMeasure20)
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
