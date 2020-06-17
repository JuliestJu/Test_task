//
//  Anoda_Test_TaskTests.swift
//  Anoda_Test_TaskTests
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import XCTest
@testable import Anoda_Test_Task

class Anoda_Test_TaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJSONserialization() {
        let jsonParcer = JSONParser()
        let dataArray = jsonParcer.parseJSON(file: "json")
        XCTAssertTrue(dataArray != nil, "JSONSerializattion problem.")
    }
    
    func testTimeDiffing() {
        let oldDate = Date(timeIntervalSince1970: 1592229090)
        let newDate = Date(timeIntervalSince1970: 1592229150)
        let diff = String.getDiffTime(olderDate: oldDate, newerDate: newDate)
        XCTAssertTrue("1 minute ago" == diff!, "Time difference isn't valid")
    }
        
    func testCalculateLikes() {
        let cellDescrView = CellDescriptionView()
        let usersArray = ["Vasya", "petya", "Sasha"]
        let result = cellDescrView.calculateLikes(from: usersArray)
        XCTAssertTrue((["Vasya", "petya", "Sasha"], "") == result)
    }    
}
