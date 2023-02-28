//
//  DessertDetailView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertDetailView: View {
    var networkController = NetworkController()
    var mealSummary: MealSummary
    @State var meal: Meal? = nil
    
    var body: some View {
        Form {
            MealTitleView(title: mealSummary.strMeal, imageURLString: mealSummary.strMealThumb)
            
            Section(header: Text("Ingredients")) {
                
                if(meal?.strIngredient1 == "") {
                    Text("No ingredients")
                }
                
                Group {
                    IngredientView(ingredient: meal?.strIngredient1, measure: meal?.strMeasure1)
                    IngredientView(ingredient: meal?.strIngredient2, measure: meal?.strMeasure2)
                    IngredientView(ingredient: meal?.strIngredient3, measure: meal?.strMeasure3)
                    IngredientView(ingredient: meal?.strIngredient4, measure: meal?.strMeasure4)
                    IngredientView(ingredient: meal?.strIngredient5, measure: meal?.strMeasure5)
                    IngredientView(ingredient: meal?.strIngredient6, measure: meal?.strMeasure6)
                    IngredientView(ingredient: meal?.strIngredient7, measure: meal?.strMeasure7)
                    IngredientView(ingredient: meal?.strIngredient8, measure: meal?.strMeasure8)
                    IngredientView(ingredient: meal?.strIngredient9, measure: meal?.strMeasure9)
                    IngredientView(ingredient: meal?.strIngredient10, measure: meal?.strMeasure10)
                    //                    IngredientView(ingredient: meal?.strIngredient10)
                }
                //
                //                Group {
                //                    IngredientView(ingredient: meal?.strIngredient11)
                //                    IngredientView(ingredient: meal?.strIngredient12)
                //                    IngredientView(ingredient: meal?.strIngredient13)
                //                    IngredientView(ingredient: meal?.strIngredient14)
                //                    IngredientView(ingredient: meal?.strIngredient15)
                //                    IngredientView(ingredient: meal?.strIngredient16)
                //                    IngredientView(ingredient: meal?.strIngredient17)
                //                    IngredientView(ingredient: meal?.strIngredient18)
                //                    IngredientView(ingredient: meal?.strIngredient19)
                //                    IngredientView(ingredient: meal?.strIngredient20)
                //                }
            }
            
            Section(header: Text("Directions")) {
                Text(meal?.strInstructions ?? "")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            Task {
                meal = await networkController.fetchDessert(withID: mealSummary.idMeal)
            }
        }
    }
}

struct IngredientView: View {
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
        DessertDetailView(mealSummary: MealSummary(strMeal: "Pancakes", strMealThumb: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg", idMeal: "52855"))
    }
}

struct MealTitleView: View {
    let title: String
    let imageURLString: String
    
    var body: some View {
        VStack() {
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
