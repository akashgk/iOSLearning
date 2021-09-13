//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by Angela Yu on 18/08/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
    // MARK: - com.akashgkrishnanakash_1.InspoQuotes.PremiumQuotes
    let productId : String = "com.akashgkrishnanakash_1.InspoQuotes.PremiumQuotes"
    
    var quotesToShow : [String] = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes : [String] = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        if isPurchased() {
            showPremiumContent()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isPurchased() ? quotesToShow.count  : quotesToShow.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.accessoryType = .none
        
        } else {
            cell.textLabel?.text = "Buy Quotes"
            cell.textLabel?.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    // MARK: - delegte methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == quotesToShow.count {
            print("Buy Quotes")
            buyPremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func buyPremiumQuotes()  {
        if SKPaymentQueue.canMakePayments() {
            print("User Can make payments")
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = self.productId
            SKPaymentQueue.default().add(paymentRequest)
        } else{
            print("User cant make payment")
        }
    }
    
    func showPremiumContent()  {
        UserDefaults.standard.setValue(true, forKey: "UserHasPurchased")
        quotesToShow.append(contentsOf: premiumQuotes)
        tableView.reloadData()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                print("success")
            } else if transaction.transactionState == .failed{
                print("failed")
                showPremiumContent()
                
            }
        }
        
    }
    
    func isPurchased() -> Bool {
        return UserDefaults.standard.bool(forKey: "UserHasPurchased")
    }

    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
    }


}
