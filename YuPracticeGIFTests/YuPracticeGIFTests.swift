//
//  YuPracticeGIFTests.swift
//  YuPracticeGIFTests
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import XCTest
@testable import YuPracticeGIF

class YuPracticeGIFTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension YuPracticeGIFTests{
  func testAPI(){
    let giphy = Giphy()
    giphy.loadGiphyTread { (result) in
      switch result{
      case .results(let data):
        let new = GiphyResponse.init(from: data)
        assert(new != nil, "Json error")
      default:
        break
}
    }
  }
}
