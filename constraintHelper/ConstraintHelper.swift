//
//  ConstraintHelper.swift
//  constraintHelper
//
//  Created by Derrick  Ho on 4/16/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

private func +<KEY,VALUE>(a: [KEY:VALUE], b: [KEY:VALUE]) -> [KEY:VALUE] {
	var d = a
	for (k, v) in b {
		d[k] = v
	}
	return d
}

struct ConstraintHelper: StringInterpolationConvertible {
	
	let uuid: String = "CH_" + NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "_")
	
	let constraintString: String
	var options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
	private var metricDict = [String : Int]()
	private var viewDict = [String : UIView]()
	var priority: Int = 1000
	
	/// every segment created by init<T>(stringInterpolationSegment expr: T) will come here as an array of Segments.
	init(stringInterpolation strings: ConstraintHelper...) {
		constraintString = strings.map({ $0.constraintString }).reduce("", combine: +)
		viewDict = strings.map({ $0.viewDict }).reduce([:], combine:+)
		metricDict = strings.map({ $0.metricDict }).reduce([:], combine:+)
		
		print(constraintString, viewDict, metricDict)
	}
	
	/// the string literal is broken up into intervals of all string and \(..) which are called segments
	init<T>(stringInterpolationSegment expr: T) {
		if let ch = expr as? ConstraintHelper {
			constraintString = ch.constraintString
			options = ch.options
			metricDict = ch.metricDict
			viewDict = ch.viewDict
			print("ConstraintHelper")
		} else if let v = expr as? UIView {
			viewDict = ["view_\(uuid)" : v]
			constraintString = "[view_\(uuid)]"
		} else if let s = expr as? String {
			constraintString = "\(s)"
			print("String")
		} else {
			constraintString = "\(String(expr))"
			print("else")
		}
	}
	
	init(_ view: UIView? = nil, length: Int? = nil, priority: Int = 1000) {
		view?.translatesAutoresizingMaskIntoConstraints = false
		if let v = view,
			let l = length
		{
			viewDict = ["view_\(uuid)" : v]
			metricDict = ["metric_\(uuid)" : l]
			constraintString = "[view_\(uuid)(metric_\(uuid)@\(priority))]"
		} else if let v = view {
			viewDict = ["view_\(uuid)" : v]
			constraintString = "[view_\(uuid)]"
		} else if let l = length {
			metricDict = ["metric_\(uuid)" : l]
			constraintString = "(metric_\(uuid)@\(priority))"
		} else {
			assertionFailure("at least view or length must be added.  Having both non existent is not allowed")
			constraintString = ""
		}
	}
	
}

extension UIView {
	func addConstraints(constraintsHelper: ConstraintHelper) {
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(constraintsHelper.constraintString,
			options: constraintsHelper.options,
			metrics: constraintsHelper.metricDict,
			views: constraintsHelper.viewDict))
	}
}

