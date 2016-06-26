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
public func ^-^(lhs: DHConstraintBuilder, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: DHConstraintBuilder, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: DHConstraintBuilder, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^<U: FloatingPointType>(lhs: DHConstraintBuilder, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: UIView, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: UIView, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: UIView, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^<U: FloatingPointType>(lhs: UIView, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: Int, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^(lhs: Int, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^<U: FloatingPointType>(lhs: U, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-\(rhs)"
}
public func ^-^<U: FloatingPointType>(lhs: U, rhs: UIView) -> DHConstraintBuilder {
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
public func |-^(lhs: Void, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "|-\(rhs)"
}
public func |-^(lhs: Void, rhs: UIView) -> DHConstraintBuilder {
	return "|-\(rhs)"
}
public func |-^(lhs: Void, rhs: Int) -> DHConstraintBuilder {
	return "|-\(rhs)"
}
public func |-^<U: FloatingPointType>(lhs: Void, rhs: U) -> DHConstraintBuilder {
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
public func ^-|(lhs: DHConstraintBuilder, rhs: Void) -> DHConstraintBuilder {
	return "\(lhs)-|"
}
public func ^-|(lhs: UIView, rhs: Void) -> DHConstraintBuilder {
	return "\(lhs)-|"
}
public func ^-|(lhs: Int, rhs: Void) -> DHConstraintBuilder {
	return "\(lhs)-|"
}
public func ^-|<U: FloatingPointType>(lhs: U, rhs: Void) -> DHConstraintBuilder {
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
public func ^>=^(lhs: DHConstraintBuilder, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: DHConstraintBuilder, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: DHConstraintBuilder, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^<U: FloatingPointType>(lhs: DHConstraintBuilder, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: UIView, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: UIView, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: UIView, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^<U: FloatingPointType>(lhs: UIView, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: Int, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^(lhs: Int, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^<U: FloatingPointType>(lhs: U, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)->=\(rhs)"
}
public func ^>=^<U: FloatingPointType>(lhs: U, rhs: UIView) -> DHConstraintBuilder {
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
public func ^<=^(lhs: DHConstraintBuilder, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: DHConstraintBuilder, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: DHConstraintBuilder, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^<U: FloatingPointType>(lhs: DHConstraintBuilder, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: UIView, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: UIView, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: UIView, rhs: Int) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^<U: FloatingPointType>(lhs: UIView, rhs: U) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: Int, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^(lhs: Int, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^<U: FloatingPointType>(lhs: U, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}
public func ^<=^<U: FloatingPointType>(lhs: U, rhs: UIView) -> DHConstraintBuilder {
	return "\(lhs)-<=\(rhs)"
}

public struct DHConstraintBuilder: StringInterpolationConvertible {
	let constraintString: String
	public var options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
	let metricDict: [String : AnyObject]
	let viewDict: [String : UIView]
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
			metricDict = [:]
			constraintString = "[view_\(uuid)]"
		} else if let s = expr as? String {
			viewDict = [:]
			metricDict = [:]
			constraintString = "\(s)"
		} else {
			viewDict = [:]
			metricDict = [:]
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
	
	public init(length: Int, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = [:]
		metricDict = ["metric_\(uuid)" : length]
		constraintString = "metric_\(uuid)@\(priority)"
	}
	
	public init(_ view: UIView, _ lengthRelation: DHConstraintRelation = .Equal, length: Int, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = ["view_\(uuid)" : view]
		metricDict = ["metric_\(uuid)" : length]
		constraintString = "[view_\(uuid)(\(lengthRelation.rawValue)metric_\(uuid)@\(priority))]"
	}
	
	public init(_ view: UIView, multipleLengths: [(relation: DHConstraintRelation, length: Int)]) {
		self.init(view, multipleLengths: multipleLengths.map({ ($0, $1, 1000) }))
	}

	public init(_ view: UIView, multipleLengths: [(DHConstraintRelation, length: Int, priority: Int)]) {
		assert(multipleLengths.count > 0, "Needs at least one")
		let uuid = __.count
		viewDict = ["view_\(uuid)" : view]
		
		var _metricDict = Dictionary<String, AnyObject>()
		multipleLengths.forEach {
			_metricDict["metric_\(__.count)"] = $0.length
			__.count = __.count &+ 1
		}
		
		metricDict = _metricDict
		
		var offset = -1
		let metricString = multipleLengths.reduce("") {
			offset += 1
			let spacer = $0.isEmpty ? "" : ", "
			return $0 + spacer + "\($1.0.rawValue)metric_\(uuid + offset)@\($1.priority)"
		}
		constraintString = "[view_\(uuid)(\(metricString))]"
	}
	
	public init<U: FloatingPointType>(length: U, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = [:]
		metricDict = ["metric_\(uuid)" : length as! AnyObject]
		constraintString = "metric_\(uuid)@\(priority)"
	}
	
	public init<U: FloatingPointType>(_ view: UIView, _ lengthRelation: DHConstraintRelation = .Equal, length: U, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = ["view_\(uuid)" : view]
		metricDict = ["metric_\(uuid)" : length as! AnyObject]
		constraintString = "[view_\(uuid)(\(lengthRelation.rawValue)metric_\(uuid)@\(priority))]"
	}
	
	public init<U: FloatingPointType>(_ view: UIView, multipleLengths: [(relation: DHConstraintRelation, length: U)]) {
		self.init(view, multipleLengths: multipleLengths.map({ ($0, $1, 1000) }))
	}
	
	public init<U: FloatingPointType>(_ view: UIView, multipleLengths: [(DHConstraintRelation, length: U, priority: Int)]) {
		assert(multipleLengths.count > 0, "Needs at least one")
		let uuid = __.count
		viewDict = ["view_\(uuid)" : view]
		
		var _metricDict = Dictionary<String, AnyObject>()
		multipleLengths.forEach {
			_metricDict["metric_\(__.count)"] = ($0.length as! AnyObject)
			__.count = __.count &+ 1
		}
		
		metricDict = _metricDict
		
		var offset = -1
		let metricString = multipleLengths.reduce("") {
			offset += 1
			let spacer = $0.isEmpty ? "" : ", "
			return $0 + spacer + "\($1.0.rawValue)metric_\(uuid + offset)@\($1.priority)"
		}
		constraintString = "[view_\(uuid)(\(metricString))]"
	}
	
	public init(_ view: UIView, _ lengthRelation: DHConstraintRelation = .Equal, lengthRelativeToView: UIView, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		let uuid2 = __.count
		__.count = __.count &+ 1
		viewDict = [
			"view_\(uuid)" : view,
			"viewR_\(uuid2)" : lengthRelativeToView
		]
		metricDict = [:]
		constraintString = "[view_\(uuid)(\(lengthRelation.rawValue)viewR_\(uuid2)@\(priority))]"
	}
	
}

public enum DHConstraintRelation: String {
	case Equal = "=="
	case GreaterThanOrEqual = ">="
	case LessThanOrEqual = "<="
}

public enum DHConstraintDirection: String {
	case V = "V:"
	case H = "H:"
	static var Vertical: DHConstraintDirection = .V
	static var Horizontal: DHConstraintDirection = .H
}

extension UIView {
	
	/**
	A helper method that adds constraints.  Automatically sets __translatesAutoresizingMaskIntoConstraints__ to __false__ and adds any views specified in the DHConstraintBuilder if needed.
	
	- Parameters:
		- constraints: The DHConstraintBuilder object.
		- setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse: By default this value is true.  If this value is true, then every view specified in the DHConstraintBuilder constraintString will have it's __translatesAutoresizingMaskIntoConstraints__ property set to false.  If this value is false then the value of each view's __translatesAutoresizingMaskIntoConstraints__ will be untouched.
	*/
	public func addConstraints(_ direction: DHConstraintDirection, _ constraints: DHConstraintBuilder, setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse: Bool = true) {
		constraints.viewDict.forEach({
			if setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse {
				$1.translatesAutoresizingMaskIntoConstraints = false
			}
			
			if self.subviews.contains($1) == false && self != $1 {
				self.addSubview($1)
			}
		})
		addConstraints(
			NSLayoutConstraint.constraintsWithVisualFormat("\(direction.rawValue)\(constraints.constraintString)",
			options: constraints.options,
			metrics: constraints.metricDict,
			views: constraints.viewDict))
	}
}

