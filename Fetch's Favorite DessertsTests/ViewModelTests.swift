//
//  Fetch_s_Favorite_DessertsTests.swift
//  Fetch's Favorite DessertsTests
//
//  Created by Conner Tate on 2/27/23.
//

import XCTest
@testable import Fetch_s_Favorite_Desserts

//All tests for the ViewModel
final class ViewModelTests: XCTestCase {
    private var sut: DessertsViewModel!
    
    override func setUpWithError() throws {
        sut = DessertsViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //ViewModel can load all desserts to its array
    func test_fetchAllDesserts_populatesDessertsArray() async {
        await sut.fetchDesserts()
        let emptyDesserts = [MealSummary]()
        
        XCTAssertNotEqual(sut.desserts, emptyDesserts)
    }
    
    //ViewModel can load a specific dessert
    func test_fetchDessertWithID_populatesDessertProperty() async {
        let expectedIngredient = "Banana"
        let expectedMeasurement = "1 large"
        
        await sut.fetchDessert(withID: "52855")

        XCTAssertNotNil(sut.dessert)
        XCTAssertEqual(sut.dessert?.strIngredient1, expectedIngredient)
        XCTAssertEqual(sut.dessert?.strMeasure1, expectedMeasurement)
    }
}
