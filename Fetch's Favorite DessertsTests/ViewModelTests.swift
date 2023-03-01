//
//  Fetch_s_Favorite_DessertsTests.swift
//  Fetch's Favorite DessertsTests
//
//  Created by Conner Tate on 2/27/23.
//

import XCTest
@testable import Fetch_s_Favorite_Desserts

final class ViewModelTests: XCTestCase {

    //ViewModel can load all desserts to its array
    func test_fetchAllDesserts_populatesDessertsArray() async {
        let sut = DessertsViewModel()
        await sut.fetchDesserts()
        let emptyDesserts = [MealSummary]()
        XCTAssertNotEqual(sut.desserts, emptyDesserts)
    }
}
