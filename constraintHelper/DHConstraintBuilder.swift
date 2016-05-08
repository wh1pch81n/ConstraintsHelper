//
//  DHConstraintBuilder.swift
//  DHConstraintBuilder
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

infix operator ^-^ { associativity left precedence 140 }
infix operator |-^ { associativity left }
infix operator ^-| { associativity left }
infix operator ^>=^ { associativity left precedence 140 }
infix operator ^<=^ { associativity left precedence 140 }

/** Short hand for linking two DHConstraintBuilder Objects */
public func ^-^<T,U>(lhs: T, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}

/** Short hand for linking one DHConstraintBuilder to the top if vertical or to the left if horizontal*/
public func |-^<T>(lhs: (Void), rhs: T) -> DHConstraintBuilder {
	return "|-\(rhs)"
}

/** Short hand for linking one DHConstraintBuilder to the bottom if vertical or to the right if horizontal*/
public func ^-|<T>(lhs: T, rhs: (Void)) -> DHConstraintBuilder {
	return "\(lhs)-|"
}

/** Short hand for linking one DHConstraintBuilder Object with a greather or equal to length */
public func ^>=^<T>(lhs: DHConstraintBuilder, rhs: T) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}

/** Short hand for linking one DHConstraintBuilder Object with a less than or equal to length */

public func ^<=^<T>(lhs: DHConstraintBuilder, rhs: T) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}

public struct DHConstraintBuilder: StringInterpolationConvertible {
	
	let constraintString: String
	public var options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
	private var metricDict = [String : Int]()
	private var viewDict = [String : UIView]()
	private struct __ {
		static var count: Int = 0
	}
	
	/// every segment created by init<T>(stringInterpolationSegment expr: T) will come here as an array of Segments.
	public init(stringInterpolation strings: DHConstraintBuilder...) {
		constraintString = strings.map({ $0.constraintString }).reduce("", combine: +)
		viewDict = strings.map({ $0.viewDict }).reduce([:], combine:+)
		metricDict = strings.map({ $0.metricDict }).reduce([:], combine:+)
	}
	
	/// the string literal is broken up into intervals of all string and \(..) which are called segments
	public init<T>(stringInterpolationSegment expr: T) {
		if let ch = expr as? DHConstraintBuilder {
			constraintString = ch.constraintString
			options = ch.options
			metricDict = ch.metricDict
			viewDict = ch.viewDict
		} else if let v = expr as? UIView {
			let uuid = __.count
			__.count = __.count &+ 1
			viewDict = ["view_\(uuid)" : v]
			constraintString = "[view_\(uuid)]"
		} else if let s = expr as? String {
			constraintString = "\(s)"
		} else {
			constraintString = "\(String(expr))"
		}
	}
	
	public init(_ view: UIView? = nil, length: Int? = nil, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		view?.translatesAutoresizingMaskIntoConstraints = false
		switch (view, length) {
		case let (v?, l?):
			viewDict = ["view_\(uuid)" : v]
			metricDict = ["metric_\(uuid)" : l]
			constraintString = "[view_\(uuid)(metric_\(uuid)@\(priority))]"
		case let (v?, nil):
			viewDict = ["view_\(uuid)" : v]
			constraintString = "[view_\(uuid)]"
		case let (nil, l?):
			metricDict = ["metric_\(uuid)" : l]
			constraintString = "(metric_\(uuid)@\(priority))"
		case (nil, nil):
			assertionFailure("at least view or length must be added.  Having both non existent is not allowed")
			constraintString = ""
		}
	}
	
}

extension UIView {
	
	public func addConstraints_H(constraints: DHConstraintBuilder) {
		addConstraints("H:\(constraints)")
	}
	
	public func addConstraints_V(constraints: DHConstraintBuilder) {
		addConstraints("V:\(constraints)")
	}
	public func addConstraints(c: DHConstraintBuilder) {
		c.viewDict.forEach({
			$1.translatesAutoresizingMaskIntoConstraints = false
			if self.subviews.contains($1) == false && self != $1 {
				self.addSubview($1)
			}
		})
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(c.constraintString,
			options: c.options,
			metrics: c.metricDict,
			views: c.viewDict))
	}
}

