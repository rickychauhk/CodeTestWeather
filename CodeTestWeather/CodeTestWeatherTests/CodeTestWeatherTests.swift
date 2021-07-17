//
//  CodeTestWeatherTests.swift
//  CodeTestWeatherTests
//
//  Created by Ricky on 17/7/2021.
//

import XCTest
@testable import CodeTestWeather

class CodeTestWeatherTests: XCTestCase {
    var viewModel: Weather!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testJSONDecoding() {
        
        // Convert restaurant.json to Data
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "restaurants", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        let resource = try! JSONDecoder().decode(Weather.self, from: data)
    
        XCTAssertEqual(resource.name, "HongKong")
    }
    
    func testResourceDetailViewModel() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "restaurants", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        let resource = try! JSONDecoder().decode(Weather.self, from: data)
        
//        guard let firResource = resource else {
//            fatalError("First Resource is nil")
//        }
        
        viewModel = Weather(value: resource)
        
        XCTAssertEqual(viewModel.name, "HongKong")
    }
    
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

}
