//
//  DessertDetailView.swift
//  Fetch's Favorite Desserts
//
//  Created by Conner Tate on 2/27/23.
//

import SwiftUI

struct DessertDetailView: View {
    
    //The specific dessert we are looking at
    var mealSummary: MealSummary
    var networkController = NetworkController()
    
    @State var meal: Meal? = nil
    @State var showNetworkErrorAlert = false
    
    /// Concurrently load the full dessert item
    func loadDessert() {
        Task(priority: .high) {
            do {
                meal = try await networkController.fetchDessert(withID: mealSummary.idMeal)
            } catch {
                showNetworkErrorAlert = true
            }
        }
    }
    
    var body: some View {
        Form {
            //Title and image
            MealTitleView(title: mealSummary.strMeal, imageURLString: mealSummary.strMealThumb)
            
            Section(header: Text("Ingredients")) {
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
                }
                
                Group {
                    IngredientView(ingredient: meal?.strIngredient11, measure: meal?.strMeasure11)
                    IngredientView(ingredient: meal?.strIngredient12, measure: meal?.strMeasure12)
                    IngredientView(ingredient: meal?.strIngredient13, measure: meal?.strMeasure13)
                    IngredientView(ingredient: meal?.strIngredient14, measure: meal?.strMeasure14)
                    IngredientView(ingredient: meal?.strIngredient15, measure: meal?.strMeasure15)
                    IngredientView(ingredient: meal?.strIngredient16, measure: meal?.strMeasure16)
                    IngredientView(ingredient: meal?.strIngredient17, measure: meal?.strMeasure17)
                    IngredientView(ingredient: meal?.strIngredient18, measure: meal?.strMeasure18)
                    IngredientView(ingredient: meal?.strIngredient19, measure: meal?.strMeasure19)
                    IngredientView(ingredient: meal?.strIngredient20, measure: meal?.strMeasure20)
                }
            }
            
            Section(header: Text("Directions")) {
                Text(meal?.strInstructions ?? "")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        //Load dessert info when view is presented
        .onAppear{
            loadDessert()
        }
        //Alert error to warn user about network issues
        .alert("Trouble connecting to the internet, please check your connection", isPresented: $showNetworkErrorAlert) {
            Button("Ok", role: .cancel) {
                showNetworkErrorAlert = false
            }
        }
    }
}

//Top view to show dessert image and title
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

//View for individual ingredient and measurement
//Returns and emptyView if there is no respective ingredient
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
