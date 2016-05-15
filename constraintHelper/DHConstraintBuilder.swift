/**
MIT License

Copyright (c) 2016 Derrick Ho

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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

/** 
Short hand for linking two DHConstraintBuilder Objects 

```
let view0 = UIView()
let view1 = UIView()
let view2 = UIView()
view0.addConstraints(view1 ^-^ view2) // view1 adjecent to view2

let view3 = UIView()
let view4 = UIView()
let view5 = UIView()
view3.addConstraints(view4 ^-^ 8 ^-^ view5) // view1 is 8 units away from view2
```
*/
public func ^-^<T,U>(lhs: T, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}

/**
Short hand for linking one DHConstraintBuilder to the top if vertical or to the left if horizontal

```
let view1 = UIView()
let view2 = UIView()
view1.addConstraints(() |-^ view2)
```
*/
public func |-^<T>(lhs: (Void), rhs: T) -> DHConstraintBuilder {
	return "|-\(rhs)"
}

/**
Short hand for linking one DHConstraintBuilder to the bottom if vertical or to the right if horizontal

```
let view1 = UIView()
let view2 = UIView()
view1.addConstraints(view2 ^-| ())
```
*/
public func ^-|<T>(lhs: T, rhs: (Void)) -> DHConstraintBuilder {
	return "\(lhs)-|"
}

/** 
Short hand for linking 2 DHConstraintBuilder objects with a gap length greather or equal to specified number

```
let view0 = UIView()
let view1 = UIView()
let view2 = UIView()
view0.addConstraints(view1 ^>=^ 8 ^-^ view2) // view1 is >=8 units away from view2
```
*/
public func ^>=^<T>(lhs: DHConstraintBuilder, rhs: T) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}

/** 
Short hand for linking 2 DHConstraintBuilder objects with a gap length less than or equal to specified number

```
let view0 = UIView()
let view1 = UIView()
let view2 = UIView()
view0.addConstraints(view1 ^<=^ 8 ^-^ view2) // view1 is <=8 units away from view2
```
*/
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
	
	/**
	Creates a DHConstraintBuilder object 
	
	- parameters:
		- view: a view
		- length: a length of a view or gap
		- priority: priority of a constraint where the range is from 1 to 1000.  Default value is 1000
	
	*/
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
			constraintString = "metric_\(uuid)@\(priority)"
		case (nil, nil):
			assertionFailure("at least view or length must be added.  Having both non existent is not allowed")
			constraintString = ""
		}
	}
	
}

extension UIView {
	/**
	A helper method that adds constraints horizontally.  Automatically sets __translatesAutoresizingMaskIntoConstraints__ to __false__ and adds any views specified in the DHConstraintBuilder if needed.
	
	- Parameters:
		- constraints: The DHConstraintBuilder object.
	*/
	public func addConstraints_H(constraints: DHConstraintBuilder) {
		addConstraints("H:\(constraints)")
	}
	
	/**
	A helper method that adds constraints vertically.  Automatically sets __translatesAutoresizingMaskIntoConstraints__ to __false__ and adds any views specified in the DHConstraintBuilder if needed.
	
	- Parameters:
		- constraints: The DHConstraintBuilder object.
	*/
	public func addConstraints_V(constraints: DHConstraintBuilder) {
		addConstraints("V:\(constraints)")
	}
	
	/**
	A helper method that adds constraints.  Automatically sets __translatesAutoresizingMaskIntoConstraints__ to __false__ and adds any views specified in the DHConstraintBuilder if needed.
	
	- Parameters:
		- constraints: The DHConstraintBuilder object.
	*/
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

