//
//  ViewController.swift
//  SampleProj_DHConstraintBuilder
//
//  Created by Derrick Ho on 12/26/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit
import DHConstraintBuilder

struct EnvironmentVariables: RawRepresentable {
	let rawValue: String

	static let dnthome_testing = EnvironmentVariables(rawValue: "dnthome_testing")
	
	var enabled: Bool {
		if let v = ProcessInfo.processInfo.environment[rawValue] {
			return (v as NSString).boolValue
		}
		return false
	}
}



class ViewController: UIViewController {
	// View that holds views for Visually formatted views
	var visualFormatView: UIView!
	// View that holds views for DHConstraintBuilder formatted views
	var dhConstraintView: UIView!

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)


		if EnvironmentVariables.dnthome_testing.enabled == false {
			let alert = UIAlertController(title: "See Tests for DHConstraintBuilder Usage examples", message: nil, preferredStyle: .alert)
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = .lightGray
		let vfvLabel = UILabel()
		vfvLabel.adjustsFontSizeToFitWidth = true
		vfvLabel.text = "NSLayoutConstraint with visual format"
		let dhLabel = UILabel()
		dhLabel.adjustsFontSizeToFitWidth = true
		dhLabel.text = "DHConstraintBuilder"
		self.visualFormatView = UIView()
		visualFormatView.backgroundColor = .white
		self.dhConstraintView = UIView()
		dhConstraintView.backgroundColor = .white
		
		// Horizontal constraints
		view.addConstraints(() |-^ vfvLabel ^-| ()).H
		view.addConstraints(() |-^ visualFormatView ^-| ()).H
		
		view.addConstraints(() |-^ dhLabel ^-| ()).H
		view.addConstraints(() |-^ dhConstraintView ^-| ()).H
		
		// Vertical Constarints
		view.addConstraints(vfvLabel.lengthEqual(to: 30)).V
		view.addConstraints(dhLabel.lengthEqual(to: 30)).V
		view.addConstraints(() |-^ 40 ^-^ vfvLabel ^-^ 0 ^-^ visualFormatView ^-^ dhLabel ^-^ 0 ^-^ dhConstraintView ^-^ 20 ^-| ()).V
		
		view.addConstraints(visualFormatView.lengthEqual(to: dhConstraintView)).V
	}
}

