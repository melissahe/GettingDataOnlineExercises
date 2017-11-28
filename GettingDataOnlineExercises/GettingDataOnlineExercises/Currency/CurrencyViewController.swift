//
//  CurrencyViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //Currency One
    @IBOutlet weak var currencyOneTextField: UITextField!
    @IBOutlet weak var currencyOneLabel: UILabel!
    
    //CurrencyTwo
    @IBOutlet weak var currencyTwoTextField: UITextField!
    @IBOutlet weak var currencyTwoLabel: UILabel!
    
    //Picker View
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    let group = DispatchGroup()
    
    var currencies: [String] = []
    var baseCurrencyChanged: Bool = false
    var baseCurrency: String = "USD" {
        didSet {
                self.grabRatesForCurrencies(self.baseCurrency, to: self.convertedCurrency)
        }
    }
    
    var convertedCurrencyChanged: Bool = false
    var convertedCurrencyRate: Double = 1 {
        didSet {
            DispatchQueue.main.async {
                if self.baseCurrencyChanged {
                    guard let text = self.currencyTwoTextField.text, let moneyAmount = Double(text) else {
                        return
                    }
                    
                    let truncatedMoneyAmount = ((moneyAmount / self.convertedCurrencyRate) * 100).rounded(.down) / 100
                    self.currencyOneTextField.text = "\(truncatedMoneyAmount)"
                    
                } else if self.convertedCurrencyChanged {
                    
                    guard let text = self.currencyOneTextField.text, let moneyAmount = Double(text) else {
                        return
                    }
                    
                    
                    let truncatedMoneyAmount = ((moneyAmount * self.convertedCurrencyRate) * 100).rounded(.down) / 100
                    self.currencyTwoTextField.text = "\(truncatedMoneyAmount)"
                    
                }
            }
        }
    }
    var convertedCurrency: String = "USD" {
        didSet {
                self.grabRatesForCurrencies(self.baseCurrency, to: self.convertedCurrency)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        currencyOneTextField.delegate = self
        currencyTwoTextField.delegate = self
        getListOfCurrencies()
        currencyOneTextField.text = "1"
        currencyOneLabel.text = "USD"
        currencyTwoTextField.text = "1"
        currencyTwoLabel.text = "USD"
    }
    
    func getListOfCurrencies() {
        let urlString = "https://api.fixer.io/latest"
        CurrencyAPIClient.manager.getCurrencies(
            from: urlString,
            completionHandler: {(currency) in
                var currencyList: [String] = []
                for key in currency.rates.keys {
                    currencyList.append(key)
                }
                
                DispatchQueue.main.async {
                    self.currencies = currencyList.sorted{$0 < $1}
                    self.currencies.forEach{print($0)}
                    
                    //to get the picker view to show all of the options
                    self.currencyPickerView.reloadAllComponents()
                    
                    let baseCurrencyIndex: Int = self.currencies.index(of: self.baseCurrency)!
                    
                    let convertedCurrencyIndex: Int = self.currencies.index(of: self.convertedCurrency)!
                    
                    self.currencyPickerView.selectRow(baseCurrencyIndex, inComponent: 0, animated: false)
                    self.currencyPickerView.selectRow(convertedCurrencyIndex, inComponent: 1, animated: false)

                }
        },
            errorHandler: {print($0)})
    }
    
    func grabRatesForCurrencies(_ currencyOne: String, to currencyTwo: String) {
        let urlString = "https://api.fixer.io/latest?base=\(currencyOne)"
     
        CurrencyAPIClient.manager.getCurrencies(
            from: urlString,
            completionHandler: { (currency) in
                
                
                    
                    if currencyOne == currencyTwo {
                        self.convertedCurrencyRate = 1
                        return
                    }
                    
                    let rate = currency.rates[currencyTwo] as! Double
                    self.convertedCurrencyRate = rate
                
                
        
        },
            errorHandler: { (error) in
                print(error)
        })
        
    }
    
    //Picker View Methods
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //to do - delegate
        if component == 0 {
            self.baseCurrencyChanged = true
            self.convertedCurrencyChanged = false
            self.baseCurrency = self.currencies[row]
            currencyOneLabel.text = currencies[row]
        } else if component == 1 {
            self.baseCurrencyChanged = false
            self.convertedCurrencyChanged = true
            self.convertedCurrency = self.currencies[row]
            
            currencyTwoLabel.text = currencies[row]
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    
    //Text Field Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let moneyAmount = Double(text) else {
            return false
        }
        
        if textField == currencyOneTextField {
            //to do - convert stuff in currency two text field
            let truncatedMoneyAmount = ((moneyAmount * convertedCurrencyRate) * 100).rounded(.down) / 100
            currencyTwoTextField.text = "\(truncatedMoneyAmount)"
        } else if textField == currencyTwoTextField {
            //to do - convert stuff in currency one text field
            let truncatedMoneyAmount = ((moneyAmount / convertedCurrencyRate) * 100).rounded(.down) / 100
            currencyOneTextField.text = "\(truncatedMoneyAmount)"
        }
        
        return true
    }
}
