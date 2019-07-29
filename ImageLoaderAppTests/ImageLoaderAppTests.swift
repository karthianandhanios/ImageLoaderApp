//
//  ImageLoaderAppTests.swift
//  ImageLoaderAppTests
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import XCTest
@testable import ImageLoaderApp

class ImageLoaderAppTests: XCTestCase {
     let timeout : TimeInterval = 10
    var searchPhotosViewModel : ImageSearchViewModel?

    override func setUp() {
        searchPhotosViewModel = ImageSearchViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchPhotos() {
        let exp = expectation(description: "Loading stories")
          var success : Bool = false
        searchPhotosViewModel?.searchImage(for: "ka", completion: {_,_ in 
             print("here is the photos searched")
            success = true
             exp.fulfill()
        })
        waitForExpectations(timeout: timeout)
        XCTAssertTrue(success)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoadImage() {
        
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
