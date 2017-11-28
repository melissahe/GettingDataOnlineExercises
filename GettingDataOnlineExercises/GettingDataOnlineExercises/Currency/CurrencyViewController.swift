//
//  CurrencyViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    //Currency One
    @IBOutlet weak var currencyOneTextField: UITextField!
    @IBOutlet weak var currencyOneLabel: UILabel!
    
    //CurrencyTwo
    @IBOutlet weak var currencyTwoTextFIeld: UITextField!
    @IBOutlet weak var currencyTwoLabel: UILabel!
    
    //Picker View
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
