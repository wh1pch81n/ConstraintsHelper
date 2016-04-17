//
//  ViewController.swift
//  constraintHelper
//
//  Created by Derrick  Ho on 4/16/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var v2: UIView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
		v.backgroundColor = .redColor()
		v2.addSubview(v)
		let ch: ConstraintHelper = "H:|-\(ConstraintHelper(length: 8))-\(ConstraintHelper(v, length: 100))"
//		let cv: ConstraintHelper = "V:|-10-[\(ConstraintHelper(v))]-\(8)-|"
		v2.addConstraints(ch)
//		v2.addConstraints(cv)
		v2.addConstraints("V:|-10-\(v)-\(8)-|")
		v2.addConstraints("V:\(ConstraintHelper(v2, length: 300))")
//v2.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(ch.constraintString, options: ch.options, metrics: ch., views: <#T##[String : AnyObject]#>))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

