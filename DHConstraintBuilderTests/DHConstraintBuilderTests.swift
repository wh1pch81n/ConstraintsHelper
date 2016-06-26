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
		do {
			let v = UIView()
			let baseCase = DHConstraintBuilder(v, length: 50)
			let expectedConstraintString = "[view_0(==metric_0@1000)]"
			let expectedOptions = NSLayoutFormatOptions(rawValue: 0)
			
			XCTAssertEqual(baseCase.constraintString, expectedConstraintString)
			XCTAssertEqual(baseCase.options, expectedOptions)
			XCTAssertEqual(baseCase.metricDict["metric_0"]! as? Int, 50)
			XCTAssertEqual(baseCase.viewDict["view_0"]!, v)
		}
		// Single View With Super view
		do {
			let v = UIView()
			let baseCase_superview = () |-^ v ^-| () // Happy Constraint
			let expectedConstraintString = "|-[view_1]-|"
			let expectedOptions = NSLayoutFormatOptions(rawValue: 0)
			
			XCTAssertEqual(baseCase_superview.constraintString, expectedConstraintString)
			XCTAssertEqual(baseCase_superview.options, expectedOptions)
			XCTAssertEqual(baseCase_superview.metricDict.count, 0)
			XCTAssertEqual(baseCase_superview.viewDict["view_1"]!, v)
		}
		
		// Single View With Length With Super view
		do {
			let v = UIView()
			let baseCase_superview = () |-^ DHConstraintBuilder(v, length: 50)
			let expectedConstraintString = "|-[view_2(==metric_2@1000)]"
			let expectedOptions = NSLayoutFormatOptions(rawValue: 0)
			
			XCTAssertEqual(baseCase_superview.constraintString, expectedConstraintString)
			XCTAssertEqual(baseCase_superview.options, expectedOptions)
			XCTAssertEqual(baseCase_superview.metricDict["metric_2"]! as? Int, 50)
			XCTAssertEqual(baseCase_superview.viewDict["view_2"]!, v)
		}

		// Joining two views within super view
		do {
			let v1 = UIView()
			let v2 = UIView()
			var baseCase_superview = () |-^ v1 ^-^ v2 ^-| ()
			baseCase_superview.options = .AlignAllCenterY
			let expectedConstraintString = "|-[view_3]-[view_4]-|"
			let expectedOptions = NSLayoutFormatOptions.AlignAllCenterY
			
			XCTAssertEqual(baseCase_superview.constraintString, expectedConstraintString)
			XCTAssertEqual(baseCase_superview.options, expectedOptions)
			XCTAssertEqual(baseCase_superview.metricDict.count, 0)
			XCTAssertEqual(baseCase_superview.viewDict["view_3"]!, v1)
			XCTAssertEqual(baseCase_superview.viewDict["view_4"]!, v2)
		}
	
		// Joining two views_custom gap
		do {
			let v1 = UIView()
			let v2 = UIView()
			let v3 = UIView()
			
			var baseCase_superview = () |-^ 1 ^-^ v1 ^-^ 1 ^-^ v2 ^-^ 2 ^-^ v3 ^-^ 3 ^-| ()
			baseCase_superview.options = .AlignAllCenterY
			let expectedConstraintString = "|-1-[view_5]-1-[view_6]-2-[view_7]-3-|"
			let expectedOptions = NSLayoutFormatOptions.AlignAllCenterY
			
			XCTAssertEqual(baseCase_superview.constraintString, expectedConstraintString)
			XCTAssertEqual(baseCase_superview.options, expectedOptions)
			XCTAssertEqual(baseCase_superview.metricDict.count, 0)
			XCTAssertEqual(baseCase_superview.viewDict["view_5"]!, v1)
			XCTAssertEqual(baseCase_superview.viewDict["view_6"]!, v2)
			XCTAssertEqual(baseCase_superview.viewDict["view_7"]!, v3)
		}

		// length with priority
		do {
			let lengthWithPriority = DHConstraintBuilder(length: 35)
			XCTAssertEqual(lengthWithPriority.constraintString, "metric_8@1000")
			
			XCTAssertEqual(lengthWithPriority.metricDict["metric_8"]! as? Int, 35)
			XCTAssertEqual(lengthWithPriority.viewDict.count, 0)

			let lengthWithPriority2 = DHConstraintBuilder(length: 89, priority: 777)
			XCTAssertEqual(lengthWithPriority2.constraintString, "metric_9@777")
			XCTAssertEqual(lengthWithPriority2.metricDict["metric_9"]! as? Int, 89)
			XCTAssertEqual(lengthWithPriority2.viewDict.count, 0)
		}
		
		// view length with relation
		do {
			let v = UIView()
			var lengthWithPriority = DHConstraintBuilder(v, .Equal, length: 35)
			XCTAssertEqual(lengthWithPriority.constraintString, "[view_10(==metric_10@1000)]")
			XCTAssertEqual(lengthWithPriority.metricDict["metric_10"]! as? Int, 35)
			XCTAssertEqual(lengthWithPriority.viewDict["view_10"], v)
			
			lengthWithPriority = DHConstraintBuilder(v, .GreaterThanOrEqual, length: 35)
			XCTAssertEqual(lengthWithPriority.constraintString, "[view_11(>=metric_11@1000)]")
			XCTAssertEqual(lengthWithPriority.metricDict["metric_11"]! as? Int, 35)
			XCTAssertEqual(lengthWithPriority.viewDict["view_11"], v)
			
			lengthWithPriority = DHConstraintBuilder(v, .LessThanOrEqual, length: 35)
			XCTAssertEqual(lengthWithPriority.constraintString, "[view_12(<=metric_12@1000)]")
			XCTAssertEqual(lengthWithPriority.metricDict["metric_12"]! as? Int, 35)
			XCTAssertEqual(lengthWithPriority.viewDict["view_12"], v)
		}
		// view with multiple length
		do {
			let v = UIView()
			var lengthWithPriority = DHConstraintBuilder(v, multipleLengths: [(.Equal, length: 55)])
			XCTAssertEqual(lengthWithPriority.constraintString, "[view_13(==metric_13@1000)]")
			XCTAssertEqual(lengthWithPriority.metricDict["metric_13"]! as? Int, 55)
			XCTAssertEqual(lengthWithPriority.viewDict["view_13"], v)
			
			lengthWithPriority = DHConstraintBuilder(v, multipleLengths: [
				(.GreaterThanOrEqual, length: 10),
				(.LessThanOrEqual, length: 100)
			])
			XCTAssertEqual(lengthWithPriority.constraintString, "[view_14(>=metric_14@1000, <=metric_15@1000)]")
			XCTAssertEqual(lengthWithPriority.metricDict["metric_14"]! as? Int, 10)
			XCTAssertEqual(lengthWithPriority.metricDict["metric_15"]! as? Int, 100)
			XCTAssertEqual(lengthWithPriority.viewDict["view_14"], v)
		}
    }
    

    
}
