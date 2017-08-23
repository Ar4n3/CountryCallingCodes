//
//  ViewController.swift
//  CountryCallingCodesDemoSwift
//
//  Created by Enara Lopez Otaegui on 23/8/17.
//  Copyright © 2017 Enara Lopez Otaegui. All rights reserved.
//

import UIKit
import CountryCallingCodes

class ViewController: UIViewController, CountryCallingCodeDelegate {
    @IBOutlet weak var countryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        CountryCallingCode.sharedInstance().delegate = self
        let buttonString = String.init(format: "%@\t%@", CountryCallingCode.sharedInstance().flag, CountryCallingCode.sharedInstance().code)
        countryButton.setTitle(buttonString, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Delegate methods
    
    func updateCountryData() {
        let buttonString = String.init(format: "%@\t%@", CountryCallingCode.sharedInstance().flag, CountryCallingCode.sharedInstance().code)
        countryButton.setTitle(buttonString, for: .normal)
    }
}

