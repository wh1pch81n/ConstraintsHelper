//
//  DHConstraintBuilderTests.swift
//  DHConstraintBuilderTests
//
//  Created by Derrick  Ho on 4/17/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import XCTest
@testable import DHConstraintBuilder

extension String {
	var noNumericalInformation: String {
		return components(separatedBy: .decimalDigits).reduce("", +)
	}
}

class DHConstraintBuilderTests: XCTestCase {
    
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
		let sut = () |-^ v
		
		XCTAssertEqual(sut.constraintString , "|-[view_0]")
		XCTAssertEqual(sut.metricDict.count, 0)
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testSuperViewWithIntegerConstraint() {
		let sut = () |-^ 5
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@1000")
		XCTAssertEqual(sut.metricDict.count, 1)
		XCTAssertEqual(sut.viewDict.count, 0)
	}
	
	func testSuperViewWithFloatingPointConstraint() {
		let sut = () |-^ 5.5
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@1000")
		XCTAssertEqual(sut.metricDict.count, 1)
		XCTAssertEqual(sut.viewDict.count, 0)
	}
	
	func testSuperViewWithDHConstraintBuilderViewWithLength() {
		let L = 5
		let v = UIView()
		let sut = () |-^ v.lengthEqual(to: L)
		
		XCTAssertEqual(sut.constraintString , "|-[view_0(==metric_0@1000)]")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testSuperViewWithDHConstraintBuilderViewWithLengthWithPriority() {
		let L = 5
		let P = 999
		let v = UIView()
		let sut = () |-^ v.lengthEqual(to: L, priority: P)
		
		XCTAssertEqual(sut.constraintString , "|-[view_0(==metric_0@999)]")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testSuperViewWithDHConstraintBuilderFloat() {
		let L = 5.5
		let sut = () |-^ L.priority(1000)
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@1000")
		XCTAssertEqual(sut.metricDict as! [String:Double], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testSuperViewWithDHConstraintBuilderInt() {
		let L = 5
		let sut = () |-^ L.priority(1000)
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@1000")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}

	func testSuperViewWithDHConstraintBuilderFloatWithPriority() {
		let L = 5.8
		let P = 999
		let sut = () |-^ L.priority(P)
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@999")
		XCTAssertEqual(sut.metricDict as! [String:Double], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testSuperViewWithDHConstraintBuilderIntWithPriority() {
		let L = 5
		let P = 999
		let sut = () |-^ L.priority(P)
		
		XCTAssertEqual(sut.constraintString , "|-metric_0@999")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	//
	func testViewWithDefaultConstraintToSuperView() {
		let v = UIView()
		let sut = v ^-| ()
		
		XCTAssertEqual(sut.constraintString , "[view_0]-|")
		XCTAssertEqual(sut.metricDict  as! [String:Int], [:])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testIntegerConstraintToSuperView() {
		let L = 5
		let sut = L ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@1000-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testFloatingPointConstraintToSuperView() {
		let L = 5.5
		let sut = L ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@1000-|")
		XCTAssertEqual(sut.metricDict["metric_0"] as! Double, L)
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testDHConstraintBuilderViewWithLengthToSuperView() {
		let L = 5
		let v = UIView()
		let sut = v.lengthEqual(to: L) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testDHConstraintBuilderViewWithLengthWithPriorityToSuperView() {
		let L = 5
		let P = 999
		let v = UIView()
		let sut = v.lengthEqual(to: L, priority: P) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@999)]-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, ["view_0" : v])
	}
	
	func testDHConstraintBuilderFloatToSuperView() {
		let L = 5.5
		let sut = L.priority(1000) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@1000-|")
		XCTAssertEqual(sut.metricDict as! [String:Double], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testDHConstraintBuilderIntToSuperView() {
		let L = 5
		let sut = L.priority(1000) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@1000-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testDHConstraintBuilderFloatWithPriorityToSuperView() {
		let L = 5
		let P = 999
		let sut = L.priority(P) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@999-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testDHConstraintBuilderIntWithPriorityToSuperView() {
		let L = 5
		let P = 999
		let sut = L.priority(P) ^-| ()
		
		XCTAssertEqual(sut.constraintString , "metric_0@999-|")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L])
		XCTAssertEqual(sut.viewDict, [:])
	}
	
	func testViewToView() {
		let v0 = UIView()
		let v1 = UIView()
		let sut = v0 ^-^ v1
		
		XCTAssertEqual(sut.constraintString , "[view_0]-[view_1]")
		XCTAssertEqual(sut.metricDict as! [String:Int], [:])
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "view_1":v1])
	}
	
	func testViewToInt() {
		let L = 5
		let v = UIView()
		let sut = v ^-^ L
		
		XCTAssertEqual(sut.constraintString , "[view_0]-metric_1@1000")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_1": L])
		XCTAssertEqual(sut.viewDict, ["view_0":v])
	}
	
	func testViewToFloat() {
		let L = 5.5
		let v = UIView()
		let sut = v ^-^ L
		
		XCTAssertEqual(sut.constraintString , "[view_0]-metric_1@1000")
		XCTAssertEqual(sut.metricDict["metric_1"] as! Double, 5.5)
		XCTAssertEqual(sut.viewDict, ["view_0":v])
	}
	
	func testDHConstraintBuilderViewLengthToView() {
		let v0 = UIView()
		let v1 = UIView()
		let L = 5
		let sut = v0.lengthEqual(to: L) ^-^ v1
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-[view_1]")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L])
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "view_1":v1])
	}
	
	func testDHConstraintBuilderViewLengthToFloat() {
		let v0 = UIView()
		let L = 5
		let F = 9.9
		let sut = v0.lengthEqual(to: L) ^-^ F
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-metric_1@1000")
        XCTAssertEqual(sut.metricDict["metric_0"] as! Int, L)
        XCTAssertEqual(sut.metricDict["metric_1"] as! Double, F)
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}

	func testDHConstraintBuilderViewLengthToInt() {
		let v0 = UIView()
		let L = 5
		let F = 9
		let sut = v0.lengthEqual(to: L) ^-^ F
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-metric_1@1000")
        XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L, "metric_1": F])
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}

	func testDHConstraintBuilderViewLengthToDHConstraintBuilderViewLength() {
		let v0 = UIView()
		let v1 = UIView()
		let L0 = 5
		let L1 = 10
		let sut = v0.lengthEqual(to: L0) ^-^ v1.lengthEqual(to: L1)
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-[view_1(==metric_1@1000)]")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L0, "metric_1":L1])
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "view_1":v1])
	}
	
	func testDHConstraintBuilderViewLengthToFloatWithPriority() {
		let v0 = UIView()
		let L = 5
		let F = 9.9
		let P = 999
		let sut = v0.lengthEqual(to: L) ^-^ F.priority(P)
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-metric_1@\(P)")
		XCTAssertEqual(sut.metricDict as NSDictionary, ["metric_0":L, "metric_1":F] as NSDictionary)
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
	func testDHConstraintBuilderViewLengthToIntWithPriority() {
		let v0 = UIView()
		let L = 5
		let F = 9
		let P = 999
		let sut = v0.lengthEqual(to: L) ^-^ F.priority(P)
		
		XCTAssertEqual(sut.constraintString , "[view_0(==metric_0@1000)]-metric_1@\(P)")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L, "metric_1": F])
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
	func testViewToGreaterThanOrEqualIntLength() {
		let v0 = UIView()
		let L0 = 5
		let relation = ">="
		let sut = v0 ^>=^ L0
		
		XCTAssertEqual(sut.constraintString, "[view_0]-\(relation)metric_1@1000")
		XCTAssertEqual(sut.metricDict["metric_1"] as! Int, L0)
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}

	func testViewToGreaterThanOrEqualFloatLength() {
		let v0 = UIView()
		let L0 = 5.6
		let relation = ">="
		let sut = v0 ^>=^ L0
		
		XCTAssertEqual(sut.constraintString, "[view_0]-\(relation)metric_1@1000")
		XCTAssertEqual(sut.metricDict["metric_1"] as! Double, L0)
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
	func testViewToGreaterThanOrEqualFloatLengthWithPriority() {
		let v0 = UIView()
		let L0 = 5.6
		let P = 999
		let relation = ">="
		let sut = v0 ^>=^ L0.priority(P)
		
		XCTAssertEqual(sut.constraintString, "[view_1]-\(relation)metric_0@\(P)")
		XCTAssertEqual(sut.metricDict as! [String:Double], ["metric_0":L0])
		XCTAssertEqual(sut.viewDict, ["view_1":v0])
	}

	func testViewToGreaterThanOrEqualIntLengthWithPriority() {
		let v0 = UIView()
		let L0 = 5
		let P = 999
		let relation = ">="
		let sut = v0 ^>=^ L0.priority(P)
		
		XCTAssertEqual(sut.constraintString, "[view_1]-\(relation)metric_0@\(P)")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L0])
		XCTAssertEqual(sut.viewDict, ["view_1":v0])
	}
	
	func testViewToLessThanOrEqualIntLength() {
		let v0 = UIView()
		let L0 = 5
		let relation = "<="
		let sut = v0 ^<=^ L0
		
		XCTAssertEqual(sut.constraintString, "[view_0]-\(relation)metric_1@1000")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_1": L0])
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
	func testViewToLessThanOrEqualFloatLength() {
		let v0 = UIView()
		let L0 = 5.6
		let relation = "<="
		let sut = v0 ^<=^ L0
		
		XCTAssertEqual(sut.constraintString, "[view_0]-\(relation)metric_1@1000")
		XCTAssertEqual(sut.metricDict["metric_1"] as! Double, L0)
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
	func testViewToLessThanOrEqualFloatLengthWithPriority() {
		let v0 = UIView()
		let L0 = 5.6
		let P = 999
		let relation = "<="
		let sut = v0 ^<=^ L0.priority(P)
		
		XCTAssertEqual(sut.constraintString, "[view_1]-\(relation)metric_0@\(P)")
		XCTAssertEqual(sut.metricDict as! [String:Double], ["metric_0":L0])
		XCTAssertEqual(sut.viewDict, ["view_1":v0])
	}
	
	func testViewToLessThanOrEqualIntLengthWithPriority() {
		let v0 = UIView()
		let L0 = 5
		let P = 999
		let relation = "<="
		let sut = v0 ^<=^ L0.priority(P)
		
		XCTAssertEqual(sut.constraintString, "[view_1]-\(relation)metric_0@\(P)")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":L0])
		XCTAssertEqual(sut.viewDict, ["view_1":v0])
	}
	
	func testMultipleRelationsLengthsOfView() {
		let v0 = UIView()
		let M0 = 10
		let M1 = 100
		let sut = v0.lengthGreaterThanOrEqual(to: M0, andLessThanOrEqualTo: M1)
		
		XCTAssertEqual(sut.constraintString, "[view_0(>=metric_0@1000,<=metric_1@1000)]")
		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":M0, "metric_1":M1])
		XCTAssertEqual(sut.viewDict, ["view_0":v0])
	}
	
//	func testRangeOfLengthsOfView() {
//		let v0 = UIView()
//		let M0 = 10
//		let M1 = 100
//		let sut = DHConstraintBuilder(v0, range: M0...M1)
//		
//		XCTAssertEqual(sut.constraintString, "[view_0(>=metric_0@1000,<=metric_1@1000)]")
//		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":M0, "metric_1":M1])
//		XCTAssertEqual(sut.viewDict, ["view_0":v0])
//	}
	
//	func testInBoundRangeOfLengthsOfView() {
//		let v0 = UIView()
//		let M0 = 10
//		let M1 = 100
//		let sut = DHConstraintBuilder(v0, range: M0..<M1)
//		
//		XCTAssertEqual(sut.constraintString, "[view_0(>=metric_0@1000,<=metric_1@1000)]")
//		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0":M0, "metric_1":M1-1])
//		XCTAssertEqual(sut.viewDict, ["view_0":v0])
//	}
	
	func testViewLengthRelationEqualToViewLength() {
		let v0 = UIView()
		let v1 = UIView()
		let sut = v0.lengthEqual(to: v1)
		                              
		XCTAssertEqual(sut.constraintString, "[view_0(==viewR_1@1000)]")
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "viewR_1":v1])
	}
	
	func testViewLengthRelationLessThanOrEqualToViewLength() {
		let v0 = UIView()
		let v1 = UIView()
		let sut = v0.lengthLessThanOrEqual(to: v1)
		
		XCTAssertEqual(sut.constraintString, "[view_0(<=viewR_1@1000)]")
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "viewR_1":v1])
	}
	
	func testViewLengthRelationGreaterThanOrEqualToViewLength() {
		let v0 = UIView()
		let v1 = UIView()
		let sut = v0.lengthGreaterThanOrEqual(to: v1)
		
		XCTAssertEqual(sut.constraintString, "[view_0(>=viewR_1@1000)]")
		XCTAssertEqual(sut.viewDict, ["view_0":v0, "viewR_1":v1])
	}
	
//	func testViewToMultipleGapLengths() {
//		let v0 = UIView()
//		let L1 = 1
//		let L2 = 5
//		let P0 = 1000
//		let P1 = 1000
//		let sut = v0 ^-^ ("(\(DHConstraintBuilder(length: L1)),\(DHConstraintBuilder(length: L2)))" as DHConstraintBuilder)
//		
//		XCTAssertEqual(sut.constraintString, "[view_2]-(metric_0@\(P0),metric_1@\(P1))")
//		XCTAssertEqual(sut.metricDict as! [String:Int], ["metric_0": L1, "metric_1": L2])
//		XCTAssertEqual(sut.viewDict, ["view_2":v0])
//	}
	
	func testViewInView() {
		let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let v2 = UIView()
		v.addConstraints(() |-^ 0 ^-^ v2 ^-^ 0 ^-| ()).H
		v.addConstraints(() |-^ 0 ^-^ v2 ^-^ 0 ^-| ()).V
		v.layoutIfNeeded()
		XCTAssertTrue(v.subviews.contains(v2))
		XCTAssertEqual(v.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
		XCTAssertEqual(v2.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
	}
	
	func testviewInViewChaining() {
		let v0 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let v1 = UIView()
		let v2 = UIView()
		v0.addConstraints(() |-^ 0 ^-^ v1 ^-^ 10 ^-^ v2 ^-^ 0 ^-| ()).H
		v0.addConstraints(() |-^ 0 ^-^ v1 ^-^ 0 ^-| ()).V
		v0.addConstraints(() |-^ 0 ^-^ v2 ^-^ 0 ^-| ()).V
		v0.addConstraints(v1.lengthEqual(to: v2)).H
		
		v0.layoutIfNeeded()
		XCTAssertTrue(v0.subviews.contains(v1))
		XCTAssertTrue(v0.subviews.contains(v2))
		XCTAssertEqual(v0.frame, CGRect(x: 0, y: 0, width: 100, height: 100))
		XCTAssertEqual(v1.frame, CGRect(x: 0, y: 0, width: 45, height: 100))
		XCTAssertEqual(v2.frame, CGRect(x: 55, y: 0, width: 45, height: 100))
	}	
}
