/**
This Test Compares constraintsWithVisualFormat:options:metrics:views: with DHConstraintBuilder.

Test Cases were derived from this Apple Document:
https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html#//apple_ref/doc/uid/TP40010853-CH27-SW1
*/

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

import XCTest

@testable import DHConstraintBuilder
@testable import SampleProj_DHConstraintBuilder

func assertEqualRect(_ view: UIView, _ view2:UIView) {
	XCTAssertNotEqual(view, view2)

	let accuracy = CGFloat(0.00001)
    XCTAssertEqual(view.frame.origin.x, view2.frame.origin.x, accuracy: accuracy)
    XCTAssertEqual(view.frame.origin.y, view2.frame.origin.y, accuracy: accuracy)
    XCTAssertEqual(view.frame.size.width, view2.frame.size.width, accuracy: accuracy)
    XCTAssertEqual(view.frame.size.height, view2.frame.size.height, accuracy: accuracy)
}

extension XCTestCase {
	func wait(forSeconds seconds: TimeInterval = 1.0) {
		let exp = expectation(description: "")
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(Int64(NSEC_PER_SEC) * Int64(seconds))) / Double(NSEC_PER_SEC), execute: {
			exp.fulfill()
		})
		waitForExpectations(timeout: seconds * 2.0, handler: nil)
	}
}

class BoxyBoxxyTests: XCTestCase {
	
	lazy var button_vf: UIButton = {
		let v = UIButton()
		v.setTitle("Button", for: UIControl.State())
		v.setTitleColor(UIColor.black, for: UIControl.State())
		v.layer.borderColor = UIColor.black.cgColor
		v.layer.borderWidth = 2
		v.layer.cornerRadius = 5
		return v
	}()
	
	lazy var button_cb: UIButton = {
		let v = UIButton()
		v.setTitle("Button", for: UIControl.State())
		v.setTitleColor(UIColor.black, for: UIControl.State())
		v.layer.borderColor = UIColor.black.cgColor
		v.layer.borderWidth = 2
		v.layer.cornerRadius = 5
		return v
	}()
	
	lazy var greenView_vf: UIView = {
		let v = UIView()
		v.backgroundColor = .green
		return v
	}()
	
	lazy var greenView_cb: UIView = {
		let v = UIView()
		v.backgroundColor = .green
		return v
	}()
	
	lazy var redView_vf: UIView = {
		let v = UIView()
		v.backgroundColor = .red
		return v
	}()
	
	lazy var redView_cb: UIView = {
		let v = UIView()
		v.backgroundColor = .red
		return v
	}()
	
	lazy var blueView_vf: UIView = {
		let v = UIView()
		v.backgroundColor = .blue
		return v
	}()
	
	lazy var blueView_cb: UIView = {
		let v = UIView()
		v.backgroundColor = .blue
		return v
	}()
	
	var mainViewController: ViewController = UIApplication.shared.keyWindow!.rootViewController! as! ViewController
	var view_vf: UIView { return mainViewController.visualFormatView }
	var view_cb: UIView { return mainViewController.dhConstraintView }
	
	override func setUp() {
		super.setUp()
		
		// Put setup code here. This method is called before the invocation of each test method in the class.
		wait(forSeconds: 0.5)
	}
	
	override func tearDown() {
		wait(forSeconds: 3)
		resetViews()
		
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func resetViews() {
		view_vf.subviews.forEach {
			$0.removeFromSuperview()
			$0.translatesAutoresizingMaskIntoConstraints = true
		}
		redView_vf.removeConstraints(redView_vf.constraints)
		greenView_vf.removeConstraints(greenView_vf.constraints)
		blueView_vf.removeConstraints(blueView_vf.constraints)
		
		view_cb.subviews.forEach {
			$0.removeFromSuperview()
			$0.translatesAutoresizingMaskIntoConstraints = true
		}
		redView_cb.removeConstraints(redView_cb.constraints)
		greenView_cb.removeConstraints(greenView_cb.constraints)
		blueView_cb.removeConstraints(blueView_cb.constraints)
		
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
	}
	
	/**
	see image "testRedGreenBlueViews" in asset Catalog
	*/
	func testRedGreenBlueViews() {
		// VisualFormat
		let viewArray = [
			greenView_vf,
			redView_vf,
			blueView_vf
		]
		viewArray.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
		viewArray.forEach(view_vf.addSubview)
		let viewDict = [
			"greenView" : greenView_vf,
			"redView" : redView_vf,
			"blueView" : blueView_vf
		]
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[greenView]-15.5-[redView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[blueView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[greenView]-[blueView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[redView]-[blueView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		greenView_vf.widthAnchor.constraint(equalTo: redView_vf.widthAnchor).isActive = true
		greenView_vf.heightAnchor.constraint(equalTo: blueView_vf.heightAnchor).isActive = true
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^ greenView_cb ^-^ 15.5 ^-^ redView_cb ^-| ()).H
		view_cb.addConstraints(() |-^ blueView_cb ^-| ()).H
		
		view_cb.addConstraints(() |-^ greenView_cb ^-^ blueView_cb ^-| ()).V
		view_cb.addConstraints(() |-^ redView_cb ^-^ blueView_cb).V
		
		view_cb.addConstraints(greenView_cb.lengthEqual(to: redView_cb)).H
		view_cb.addConstraints(greenView_cb.lengthEqual(to: blueView_cb)).V
		
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(redView_vf, redView_cb)
		assertEqualRect(greenView_vf, greenView_cb)
		assertEqualRect(blueView_vf, blueView_cb)
	}
	/**
	[button]-[textField]
	*/
	func testStandardSpace() {
		// Visual Format
		let viewArray = [button_vf, redView_vf]
		viewArray.forEach(view_vf.addSubview)
		viewArray.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
		let viewDict = ["button" : button_vf, "redView" : redView_vf]
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-[redView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(30)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[redView(30)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// dhconstraints
		view_cb.addConstraints(() |-^ button_cb ^-^ 8 ^-^ redView_cb ^-| ()).H
		view_cb.addConstraints(button_cb.lengthEqual(to: 30) ^-| ()).V
		view_cb.addConstraints(redView_cb.lengthEqual(to: 30) ^-| ()).V
		
		
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(button_vf, button_cb)
		assertEqualRect(redView_vf, redView_cb)
	}
	
	/**
	[button(>=50)]
	*/
	func testTextWidthConstraint() {
		// Visual format
		button_vf.translatesAutoresizingMaskIntoConstraints = false
		view_vf.addSubview(button_vf)
		let viewDict = ["button" : button_vf]
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[button(>=50)]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// DHConstraintBuilder
		view_cb.addConstraints(button_cb.lengthGreaterThanOrEqual(to: 50) ^-| ()).H
		view_cb.addConstraints(button_cb ^-| ()).V
		
		//Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(button_vf, button_cb)
	}
	
	/**
	|-50-[blueBox]-50-|
	
	*/
	func testConnectionToSuperview() {
		// Visual format
		blueView_vf.translatesAutoresizingMaskIntoConstraints = false
		view_vf.addSubview(blueView_vf)
		let viewDict = ["blueView" : blueView_vf]
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[blueView]-50-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[blueView]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^ 50 ^-^ blueView_cb ^-^ 50 ^-| ()).H
		view_cb.addConstraints(() |-^ blueView_cb ^-| ()).V
		
		//Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(blueView_vf, blueView_cb)
	}
	
	/**
	V:[topField]-10-[bottomField]
	
	*/
	func testVerticalLayout() {
		// Visual Format
		let viewDict = ["greenView" : greenView_vf, "redView" : redView_vf]
		Array(viewDict.values).forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			self.view_vf.addSubview($0)
		}
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[greenView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[redView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[greenView(30)]-10-[redView(30)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^ 0 ^-^ greenView_cb ^-^ 0 ^-| ()).H
		view_cb.addConstraints(() |-^ 0 ^-^ redView_cb ^-^ 0 ^-| ()).H
		view_cb.addConstraints(() |-^
			greenView_cb.lengthEqual(to: 30) ^-^
			10 ^-^
			redView_cb.lengthEqual(to: 30)).V
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(greenView_vf, greenView_cb)
		assertEqualRect(redView_vf, redView_cb)
	}
	
	/**
	[maroonView][blueView]
	
	*/
	func testFlushViews() {
		// Visual Format
		let viewDict = ["redView" : redView_vf, "blueView" : blueView_vf]
		Array(viewDict.values).forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			self.view_vf.addSubview($0)
		}
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[redView]-0-[blueView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[redView(30)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[blueView(30)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		redView_vf.widthAnchor.constraint(equalTo: blueView_vf.widthAnchor).isActive = true
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^ 0 ^-^ redView_cb ^-^ 0 ^-^ blueView_cb ^-^ 0 ^-| ()).H
		view_cb.addConstraints(() |-^ redView_cb.lengthEqual(to: 30)).V
		view_cb.addConstraints(() |-^ blueView_cb.lengthEqual(to: 30)).V
		view_cb.addConstraints(redView_cb.lengthEqual(to: blueView_cb)).H
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(greenView_vf, greenView_cb)
		assertEqualRect(redView_vf, redView_cb)
	}
	
	/**
	Priority
	[button(100@20)]
	*/
	func testPriority() {
		// Visual Format
		let viewDict = ["button" : button_vf]
		Array(viewDict.values).forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			self.view_vf.addSubview($0)
		}
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button(100@20)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button(100@20)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^ button_cb.lengthEqual(to: 100, priority: 20)).H
		view_cb.addConstraints(() |-^ button_cb.lengthEqual(to: 100, priority: 20)).V
		
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(button_vf, button_cb)
	}
	
	/**
	Equal Widths
	[button1(==button2)]
	*/
	func testEqualWidths() {
		// VisualFormat
		let viewArray = [
			button_vf,
			blueView_vf
		]
		viewArray.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
		viewArray.forEach(view_vf.addSubview)
		let viewDict = [
			"button" : button_vf,
			"blueView" : blueView_vf
		]
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[button]-0-[blueView]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: viewDict))
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==blueView)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[button]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[blueView(10)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		
		// DHConstraints
		var constr = () |-^ 0 ^-^ button_cb ^-^ 0 ^-^ blueView_cb ^-^ 0 ^-| ()
		constr.options = NSLayoutConstraint.FormatOptions.alignAllCenterY
		view_cb.addConstraints(constr).H
		
		view_cb.addConstraints(button_cb.lengthEqual(to: blueView_cb)).H
		
		view_cb.addConstraints(() |-^ 100 ^-^ button_cb).V
		
		view_cb.addConstraints(blueView_cb.lengthEqual(to: 10)).V
		
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(button_vf, button_cb)
		assertEqualRect(blueView_vf, blueView_cb)
		
	}
	//	Multiple Predicates
	//	[flexibleButton(>=70,<=100)]
	
	func testMultiplePredicates() {
		// Visual Format
		let viewDict = ["button" : button_vf]
		Array(viewDict.values).forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			self.view_vf.addSubview($0)
		}
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button(>=70,<=100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		view_vf.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button(>=70,<=100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict))
		
		// DHConstraintBuilder
		view_cb.addConstraints(() |-^
			button_cb.lengthGreaterThanOrEqual(to: 70,
			                                   andLessThanOrEqualTo: 100)).H
		view_cb.addConstraints(() |-^
			button_cb.lengthGreaterThanOrEqual(to: 70,
			                                   andLessThanOrEqualTo: 100)).V
		
		// Test
		view_vf.layoutSubviews()
		view_cb.layoutSubviews()
		assertEqualRect(button_vf, button_cb)
	}
	
	//	A Complete Line of Layout
	//	|-[find]-[findNext]-[findField(>=20)]-|
}
