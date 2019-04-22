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

/**
Used to merge two dictionary objects into one.  If "b" contains Keys that "a" has, "b" will overwrite "a"'s values for that.
*/
private func +<VALUE>(a: [String:VALUE], b: [String:VALUE]) -> [String:VALUE] {
	var d = a
	for (k, v) in b {
		d[k] = v
	}
	return d
}

precedencegroup ConstraintBuilder {
	associativity: left
	higherThan: AdditionPrecedence
}

infix operator ^-^ : ConstraintBuilder
infix operator |-^ : ConstraintBuilder
infix operator ^-| : ConstraintBuilder

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

public func ^-^(lhs: DHConstraintBuilder, rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return "\(lhs)-\(rhs)"
}

public func ^-^(lhs: UIView, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return "\(lhs)-\(rhs)"
}

public func ^-^(lhs: UIView, rhs: UIView) -> DHConstraintBuilder {
    return "\(lhs)-\(rhs)"
}

public func ^-^(lhs: UIView, rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return "\(lhs)-\(rhs)"
}

public func ^-^(lhs: DHConstraintScalar, rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return "\(lhs)-\(rhs)"
}

public func ^-^(lhs: DHConstraintScalar, rhs: UIView) -> DHConstraintBuilder {
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
public func |-^(lhs: (Void), rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return "|-\(rhs)"
}

public func |-^(lhs: (Void), rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return "|-\(rhs)"
}

public func |-^(lhs: (Void), rhs: UIView) -> DHConstraintBuilder {
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
public func ^-|(lhs: DHConstraintBuilder, rhs: (Void)) -> DHConstraintBuilder {
    return "\(lhs)-|"
}

public func ^-|(lhs: DHConstraintScalar, rhs: (Void)) -> DHConstraintBuilder {
    return "\(lhs)-|"
}


public func ^-|(lhs: UIView, rhs: (Void)) -> DHConstraintBuilder {
    return "\(lhs)-|"
}

prefix operator ==
public prefix func ==(rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return "==\(rhs)"
}

public prefix func ==(rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return "==\(rhs)"
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
prefix operator >=
public prefix func >=(rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return ">=\(rhs)"
}

public prefix func >=(rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return ">=\(rhs)"
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
prefix operator <=
public prefix func <=(rhs: DHConstraintScalar) -> DHConstraintBuilder {
    return "<=\(rhs)"
}

public prefix func <=(rhs: DHConstraintBuilder) -> DHConstraintBuilder {
    return "<=\(rhs)"
}

public protocol DHConstraintScalar {}

extension Int: DHConstraintScalar {}
extension CGFloat: DHConstraintScalar {}
extension Double: DHConstraintScalar {}

extension UIView {
	// MARK: - Equal
	public func lengthEqual(to: DHConstraintScalar) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .equal1(to: to))
	}
	
	public func lengthEqual(to: DHConstraintScalar, priority: Int) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .equal2(to: to, priority: priority))
	}
	
	public func lengthEqual(to view: UIView) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, lengthRelativeToView: view)
	}
	
	// MARK: - Greater than
	public func lengthGreaterThanOrEqual(to: DHConstraintScalar) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .greaterThanOrEqual1(to: to))
	}
	
	public func lengthGreaterThanOrEqual(to: DHConstraintScalar, priority: Int) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .greaterThanOrEqual2(to: to, priority: priority))
	}
	
	public func lengthGreaterThanOrEqual(to view: UIView) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .greaterThanOrEqual, lengthRelativeToView: view)
	}
	
	// MARK: - Less than
	public func lengthLessThanOrEqual(to: DHConstraintScalar) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .lessThanOrEqual1(to: to))
	}
	
	public func lengthLessThanOrEqual(to: DHConstraintScalar, priority: Int) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .lessThanOrEqual2(to: to, priority: priority))
	}
	
	public func lengthLessThanOrEqual(to view: UIView) -> DHConstraintBuilder {
		return DHConstraintBuilder(self, .lessThanOrEqual, lengthRelativeToView: view)
	}

	// MARK: - Mixed
	public func lengthGreaterThanOrEqual(to s0: DHConstraintScalar, priority p0: Int = 1000
		, andLessThanOrEqualTo s1: DHConstraintScalar, priority p1: Int = 1000) -> DHConstraintBuilder {
		return DHConstraintBuilder(self
			, .greaterThanOrEqual2(to: s0, priority: p0)
			, .lessThanOrEqual2(to: s1, priority: p1))
	}
}

extension DHConstraintScalar {
	public func priority(_ p: Int) -> DHConstraintBuilder {
		return DHConstraintBuilder(length: self, priority: p)
	}
}

public struct DHConstraintBuilder: ExpressibleByStringInterpolation {
    public struct StringInterpolation: StringInterpolationProtocol {
        
        /// Constraint String
        var constraintString: String = ""
        /// Holds accumulated metric data
        var metricDict: [String : DHConstraintScalar] = [:]
        /// Holds accumulated view data
        var viewDict: [String : UIView] = [:]
        var options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions(rawValue: 0)

        public init(literalCapacity: Int, interpolationCount: Int) {
            constraintString.reserveCapacity(literalCapacity * 2)
        }

        public mutating func appendLiteral(_ literal: String) {
            constraintString += literal
        }
        
        public mutating func appendInterpolation(_ scalar: DHConstraintScalar) {
            let _c: DHConstraintBuilder = DHConstraintBuilder(length: scalar)
            viewDict = viewDict + _c.viewDict
            metricDict = metricDict + _c.metricDict
            constraintString += _c.constraintString
        }
        
        public mutating func appendInterpolation(_ view: UIView) {
            let uuid = __.count
            __.count = __.count &+ 1
            viewDict = viewDict + ["view_\(uuid)" : view]
            metricDict = metricDict + [:]
            constraintString += "[view_\(uuid)]"
        }
        
        public mutating func appendInterpolation(_ builder: DHConstraintBuilder) {
            constraintString += builder.constraintString
            options.formUnion(builder.options)
            metricDict = metricDict + builder.metricDict
            viewDict = viewDict + builder.viewDict
        }
        
    }
    
	/// The Generated Constraint String
	let constraintString: String
	
	/// Align all views according to NSLayoutFormatOptions
	public var options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions(rawValue: 0)
	/// Holds accumulated metric data
	let metricDict: [String : DHConstraintScalar]
	/// Holds accumulated view data
	let viewDict: [String : UIView]
    struct __ {
        static var count: Int = 0
    }

    public init(stringLiteral value: String) {
        constraintString = value
        metricDict = [:]
        viewDict = [:]
    }
    
    public init(stringInterpolation: StringInterpolation) {
        constraintString = stringInterpolation.constraintString
        metricDict = stringInterpolation.metricDict
        viewDict = stringInterpolation.viewDict
    }
	
	/**
	Creates a DHConstraintBuilder object 
	
	- parameters:
		- view: a view
		- length: a length of a view or gap
		- priority: priority of a constraint where the range is from 1 to 1000.  Default value is 1000
	
	*/
	
	fileprivate init(length: DHConstraintScalar, priority: Int = 1000) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = [:]
		metricDict = ["metric_\(uuid)" : length]
		constraintString = "metric_\(uuid)@\(priority)"
	}
	
	fileprivate init(_ view: UIView, _ relation: DHConstraintRelation) {
		let uuid = __.count
		__.count = __.count &+ 1
		viewDict = ["view_\(uuid)" : view]
		metricDict = ["metric_\(uuid)" : relation.length]
		constraintString = "[view_\(uuid)(\(relation.relation)metric_\(uuid)@\(relation.priority))]"
	}
	
	fileprivate init(_ view: UIView, _ relations: DHConstraintRelation...) {
		//assert(relations.count > 0, "Needs at least one")
		let uuid = __.count
		viewDict = ["view_\(uuid)" : view]
		
		var _metricDict = Dictionary<String, DHConstraintScalar>()
		relations.forEach {
			_metricDict["metric_\(__.count)"] = $0.length
			__.count = __.count &+ 1
		}
		
		metricDict = _metricDict
		
		var offset = -1
		let metricString = relations.reduce("") {
			offset += 1
			let spacer = $0.isEmpty ? "" : ","
			return $0 + spacer + "\($1.relation)metric_\(uuid + offset)@\($1.priority)"
		}
		constraintString = "[view_\(uuid)(\(metricString))]"
	}
	
	fileprivate init(_ view: UIView, _ relation: DHConstraintRelation = .equal, lengthRelativeToView: UIView) {
		let uuid = __.count
		__.count = __.count &+ 1
		let uuid2 = __.count
		__.count = __.count &+ 1
		viewDict = [
			"view_\(uuid)" : view,
			"viewR_\(uuid2)" : lengthRelativeToView
		]
		metricDict = [:]
		constraintString = "[view_\(uuid)(\(relation.relation)viewR_\(uuid2)@\(relation.priority))]"
	}
	
}

private enum DHConstraintRelation {
	case greaterThanOrEqual
	case greaterThanOrEqual1(to: DHConstraintScalar)
	case greaterThanOrEqual2(to: DHConstraintScalar, priority: Int)
	
	case lessThanOrEqual
	case lessThanOrEqual1(to: DHConstraintScalar)
	case lessThanOrEqual2(to: DHConstraintScalar, priority: Int)
	
	case equal
	case equal1(to: DHConstraintScalar)
	case equal2(to: DHConstraintScalar, priority: Int)
	
	var relation: String {
		switch self {
		case .greaterThanOrEqual, .greaterThanOrEqual1, .greaterThanOrEqual2:
			return ">="
		case .lessThanOrEqual, .lessThanOrEqual1, .lessThanOrEqual2:
			return "<="
		case .equal, .equal1, .equal2:
			return "=="
		}
	}
	
	var length: DHConstraintScalar {
		switch self {
		case .greaterThanOrEqual1(to: let n):
			return n
		case .greaterThanOrEqual2(to: let n, priority: _):
			return n
		case .lessThanOrEqual1(to: let n):
			return n
		case .lessThanOrEqual2(to: let n, priority: _):
			return n
		case .equal1(to: let n):
			return n
		case .equal2(to: let n, priority: _):
			return n
		default:
			return 0
		}
	}
	
	var priority: Int {
		switch self {
		case .greaterThanOrEqual2(to: _, priority: let p):
			return p
		case .lessThanOrEqual2(to: _, priority: let p):
			return p
		case .equal2(to: _, priority: let p):
			return p
		default:
			return 1000
		}
	}
}

public enum DHConstraintDirection: String {
	case V = "V:"
	case H = "H:"
	static var Vertical: DHConstraintDirection = .V
	static var Horizontal: DHConstraintDirection = .H
}

extension UIView {
	
	public struct ConstraintDirection {
		private let _direction: (DHConstraintDirection) -> ()
		
		public var H: Void {
			direction(.H)
		}
		public var V: Void {
			direction(.V)
		}
		
		init(directionBlock: @escaping (DHConstraintDirection) -> ()) {
			_direction = directionBlock
		}
		private func direction(_ direction: DHConstraintDirection) {
			_direction(direction)
		}
	}
	
	/**
	A helper method that adds constraints.  Automatically sets __translatesAutoresizingMaskIntoConstraints__ to __false__ and adds any views specified in the DHConstraintBuilder if needed.
	
	- Parameters:
		- constraints: The DHConstraintBuilder object.
		- setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse: By default this value is true.  If this value is true, then every view specified in the DHConstraintBuilder constraintString will have it's __translatesAutoresizingMaskIntoConstraints__ property set to false.  If this value is false then the value of each view's __translatesAutoresizingMaskIntoConstraints__ will be untouched.
	*/
	public func addConstraints(
		_ constraints: DHConstraintBuilder,
		setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse: Bool = true)
		->
		ConstraintDirection
	{
		return ConstraintDirection(directionBlock: { (direction: DHConstraintDirection) -> () in
			constraints.viewDict.forEach({
				if setAllViewsTranslatesAutoresizingMaskIntoConstraintsToFalse {
					$1.translatesAutoresizingMaskIntoConstraints = false
				}
				
				if self.subviews.contains($1) == false && self != $1 {
					self.addSubview($1)
				}
			})
			self.addConstraints(self.produce(direction, layoutConstraintsFrom: constraints))
		})
	}
	
	private func produce(_ direction: DHConstraintDirection, layoutConstraintsFrom builder: DHConstraintBuilder) -> [NSLayoutConstraint]
	{
		let constraints = builder
		return NSLayoutConstraint.constraints(withVisualFormat: direction.rawValue + constraints.constraintString,
		                                      options: constraints.options,
		                                      metrics: constraints.metricDict,
		                                      views: constraints.viewDict)
	}
	
	public func produceHorizontalLayoutConstraints(from builder: DHConstraintBuilder) -> [NSLayoutConstraint]
	{
		return produce(DHConstraintDirection.Horizontal, layoutConstraintsFrom: builder)
	}
	
	public func produceVerticalLayoutConstraints(from builder: DHConstraintBuilder) -> [NSLayoutConstraint]
	{
		return produce(DHConstraintDirection.Vertical, layoutConstraintsFrom: builder)
	}
}

/**
Objective-c compatable wrapper
*/

public class DHConstraintBuilderObjc: NSObject {
	
	private(set) var _constraintBuilder: DHConstraintBuilder
	
	// MARK: - Wrapping a view in a DHConstraintBuilderObjc object
	public init(view: UIView) {
        _constraintBuilder = "\(view)"
		super.init()
	}
	
	public init(view: UIView, ofLength length: CGFloat) {
		_constraintBuilder = view.lengthEqual(to: length)
		super.init()
	}
	
	// MARK: - Wrapping a scalar in a DHConstraintBuilderObjc object
	public init(length: CGFloat) {
        _constraintBuilder = "\(length)"
		super.init()
	}
	
	public init(length: CGFloat, withPriority priority: Int) {
		_constraintBuilder = length.priority(priority)
		super.init()
	}
	
	// MARK: - Build methods
	
	public func appendConstraintBuilder(_ builder: DHConstraintBuilderObjc) -> Self {
		_constraintBuilder = _constraintBuilder ^-^ builder._constraintBuilder
		return self
	}
	
	public class func prefixSuperViewToConstraintBuilder(_ builder: DHConstraintBuilderObjc) -> DHConstraintBuilderObjc {
		let c = DHConstraintBuilderObjc(length: 0)
		c._constraintBuilder = () |-^ builder._constraintBuilder
		return c
	}
	
	public class func postfixSuperViewToConstraintBuilder(_ builder: DHConstraintBuilderObjc) -> DHConstraintBuilderObjc {
		let c = DHConstraintBuilderObjc(length: 0)
		c._constraintBuilder = builder._constraintBuilder ^-| ()
		return c
	}
}
