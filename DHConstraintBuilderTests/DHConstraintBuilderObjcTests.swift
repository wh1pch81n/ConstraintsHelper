//
//  DHConstraintBuilderObjcTests.swift
//  constraintHelper
//
//  Created by Derrick Ho on 12/27/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import XCTest
@testable import DHConstraintBuilder

// MARK: - Objective-c compatable api Tests
class DHConstraintBuilderObjcTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		DHConstraintBuilder.__.count = 0
		super.tearDown()
	}
	
	func testSuperViewWithDefaultConstraintToView() {
		let v = UIView()
		let sut = DHConstraintBuilderObjc.prefixSuperViewToConstraintBuilder(DHConstraintBuilderObjc(view: v))
			._constraintBuilder
		
		XCTAssertEqual(sut.constraintString , "|-[view_0]")
		XCTAssertEqual(sut.metricDict.count, 0)
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testSuperViewWithFloatingPointConstraint() {
		let sut = DHConstraintBuilderObjc.prefixSuperViewToConstraintBuilder(DHConstraintBuilderObjc(length: 5.5))
			._constraintBuilder
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@1000")
		XCTAssertEqual(sut.metricDict.count, 1)
		XCTAssertEqual(sut.viewDict.count, 0)
	}
	
	func testSuperViewWithDHConstraintBuilderViewWithLength() {
		let L = Float(5.0)
		let v = UIView()
		let sut = DHConstraintBuilderObjc.prefixSuperViewToConstraintBuilder(
			DHConstraintBuilderObjc(view: v, ofLength: L))._constraintBuilder
		
		XCTAssertEqual(sut.constraintString , "|-[view_0(==metric_0@1000)]")
		XCTAssertEqual(sut.metricDict as! [String:Float], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testViewToView() {
		
	}
}
