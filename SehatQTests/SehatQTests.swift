//
//  SehatQTests.swift
//  SehatQTests
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import XCTest
@testable import SehatQ

class SehatQTests: XCTestCase {

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

    func testViewController() {
        var storyBoard: UIStoryboard?
        var anyVC: AnyObject?
        var viewController: LoginViewController?

        storyBoard = UIStoryboard(name:"Login", bundle: nil)
        XCTAssert(storyBoard != nil, "Test Not Configured Properly")

        anyVC = storyBoard?.instantiateInitialViewController()
        viewController = anyVC as? LoginViewController
        XCTAssert(viewController != nil, "Test Not Configured Properly")

        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testSuccessSignInWithEmail() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSuccessSignInGoogle() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSuccessSignInFacebook() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFailedSignInGoogle() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFailedSignInFacebook() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSuccesLoadApi() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFailedLoadApi() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testResultProductListData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testResultCategoryListData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testResultSearchListData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testResultProductDetailData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testResultPurchaseProductListData() {
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
