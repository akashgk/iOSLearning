//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager : CoinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}

// MARK: - Ui picker view
extension ViewController :  UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // how many columns in each row
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currenyLabel = coinManager.currencyArray[row]
        currencyLabel.text = currenyLabel
        coinManager.getCoinPrice(for: currenyLabel)
        
    }
}


// MARK: - Coin Manager

extension ViewController : CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print("error")
    }
    
    func didUpdateCurrency(rate: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.3f", rate)
        }
    }
}
