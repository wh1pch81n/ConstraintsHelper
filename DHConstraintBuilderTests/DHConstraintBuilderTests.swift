//
//  DHConstraintBuilderTests.swift
//  DHConstraintBuilderTests
//
//  Created by Derrick  Ho on 4/17/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import XCTest
@testable import DHConstraintBuilder

class DHConstraintBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

		// Single View Tests
		let baseCase: DHConstraintBuilder = "\(DHConstraintBuilder(UIView()))"
		let baseCase_Length: DHConstraintBuilder = "\(DHConstraintBuilder(UIView(), length: 5))"
		
		let simplifiedCase: DHConstraintBuilder = "\(UIView())"
		
		// Single View With Super view
		let baseCase_superview: DHConstraintBuilder = "|-\(DHConstraintBuilder(UIView()))-|"
		let baseCase_Length_superview: DHConstraintBuilder = "|-\(DHConstraintBuilder(UIView(), length: 5))-|"
		
		let simplifiedCase_superview: DHConstraintBuilder = "|-\(UIView())-|"
		let shorthandCase_superview: DHConstraintBuilder = () |-^ UIView() ^-| ()
		let shorthandCase_superview_viewlength: DHConstraintBuilder = () |-^ DHConstraintBuilder(UIView(), length: 15) ^-| ()
		
		// Joining two views
		let baseCase_join: DHConstraintBuilder = "\(DHConstraintBuilder(UIView()))-\(DHConstraintBuilder(UIView()))"
		let baseCase_join_length: DHConstraintBuilder = "\(DHConstraintBuilder(UIView(), length: 50))-\(DHConstraintBuilder(UIView(), length: 40))"
		let simplified_join: DHConstraintBuilder = "\(UIView())-\(UIView())"
		let shorthandCase_join:DHConstraintBuilder = UIView() ^-^ UIView()
		
		// Joining two views_custom gap
		let baseCase_join_gap: DHConstraintBuilder = "\(DHConstraintBuilder(UIView()))-123-\(DHConstraintBuilder(UIView()))"
		let baseCase_join_length_gap: DHConstraintBuilder = "\(DHConstraintBuilder(UIView(), length: 50))-123-\(DHConstraintBuilder(UIView(), length: 40))"
		let simplified_join_gap: DHConstraintBuilder = "\(UIView())-123-\(UIView())"
		let shorthandCase_join_gap:DHConstraintBuilder = UIView() ^-^ 123 ^-^ UIView()
		
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
