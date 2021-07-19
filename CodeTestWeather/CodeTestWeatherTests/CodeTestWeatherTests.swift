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
    var weather: [Weather] = []
    
    override func setUp() {
       
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testJSONDecoding() {
        
        // Convert weather.json to Data
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "weather", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        let resource = try! JSONDecoder().decode(Weather.self, from: data)
    
        XCTAssertEqual(resource.name, "HongKong")
    }
    
    func testResourceDetailViewModel() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "weather", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        let resource = try! JSONDecoder().decode(Weather.self, from: data)

        viewModel = Weather(value: resource)
     
        self.weather.append(resource)
     
        XCTAssertEqual(viewModel.name, "HongKong")
        XCTAssertEqual(viewModel.weather[0].weatherDescription, "few clouds")
        XCTAssertEqual(viewModel.main?.temp.stringValue , "308.17")
        XCTAssertEqual(viewModel.main?.humidity, 5)
        XCTAssertEqual(viewModel.weather[0].iconStringURL, "https://openweathermap.org/img/wn/02d@2x.png")
        
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
