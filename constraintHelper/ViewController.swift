//
//  ViewController.swift
//  constraintHelper
//
//  Created by Derrick  Ho on 4/16/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let v0 = UIView()
		v0.backgroundColor = .redColor()
		let v1 = UIView()
		v1.backgroundColor = .greenColor()
		let v2 = UIView()
		v2.backgroundColor = .blueColor()
		
		view.addConstraints_H("|-\(v0)-|")
		view.addConstraints_V("|-\(v0)-|")
		
		v0.addConstraints_H("|-\(v1)-|")
		v0.addConstraints_V("|-\(v1)-|")
		
		v1.addConstraints_H("|-10-\(DHConstraintBuilder(v2, length: 50))")
		v1.addConstraints_V("|-\(30)-\(DHConstraintBuilder(v2, length: 60))")
		
		let v3 = UIView()
		v3.backgroundColor = .yellowColor()
		let v4 = UIView()
		v4.backgroundColor = .orangeColor()
		
		v1.addConstraints_H(() |-^ DHConstraintBuilder(v3) ^-^ 5 ^-^ DHConstraintBuilder(v4, length: 5) ^-| ())
		v1.addConstraints_V(DHConstraintBuilder(v3, length: 20) ^-| ())
		v1.addConstraints_V(DHConstraintBuilder(v4, length: 40) ^-^ 0 ^-| ())
		print("=======")
		let ch: DHConstraintBuilder = DHConstraintBuilder(v2) ^>=^ 8 ^-^ DHConstraintBuilder(v3, length: 5)
		print(ch)
	}
}

