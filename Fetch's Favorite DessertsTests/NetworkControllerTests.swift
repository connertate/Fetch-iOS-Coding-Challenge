//
//  NetworkControllerTests.swift
//  Fetch's Favorite DessertsTests
//
//  Created by Conner Tate on 3/1/23.
//

import XCTest

//All tests for the NetworkController
final class NetworkControllerTests: XCTestCase {
    private var sut: NetworkController!

    override func setUpWithError() throws {
        sut = NetworkController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //Network controller returns array of meal summaries
    func test_mealSummaryRequest_returnsArrayOfMealSummaries() async {
        let emptyArray: [MealSummary] = []
        var allDesserts: [MealSummary] = []
        
        
        do {
            allDesserts = try await sut.fetchDesserts()
        } catch {
            
        }
        
        XCTAssertNotEqual(allDesserts, emptyArray)
    }
    
    //Network controller throws an error when asking for an empty mealID
    func test_emptyMealIDRequest_returnsError() async {
        var errorThrown = false
        let expected = true
        
        do {
            _ = try await sut.fetchDessert(withID: "")
        } catch {
            errorThrown = true
        }
        
        XCTAssertEqual(errorThrown, expected)
    }
    
    //Network controller returns a meal object when given a mealID
    func test_validMealIDRequest_MealObject() async {
        let expectedIngredient = "Banana"
        let expectedMeasurement = "1 large"
        
        var meal: Meal? = nil
        do {
            meal = try await sut.fetchDessert(withID: "52855")
        } catch {
            
        }
        
        XCTAssertEqual(meal?.strIngredient1, expectedIngredient)
        XCTAssertEqual(meal?.strMeasure1, expectedMeasurement)
    }
}
