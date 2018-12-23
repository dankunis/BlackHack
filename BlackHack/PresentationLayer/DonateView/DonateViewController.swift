//
//  DonateViewController.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var wantedAmmount: UILabel!
    @IBOutlet weak var currentAmount: UILabel!
    @IBOutlet weak var reqDescription: UITextView!
    @IBOutlet weak var insertAmountTextField: UITextField!
    
    // MARK: - Private fields
    
    public var request: AllRequestsResponse!
    
    private var donationAmount: uint = 0
    
    // MARK: - Private methods
    
    private func configureUI() {
        reqDescription.text = request.body.description
        wantedAmmount.text = String(request.body.wantedAmount)
        currentAmount.text = String(request.body.currentAmount)
    }
    
    private func showAlertWithMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func validateInput() -> Bool {
        guard
            let stringAmount = insertAmountTextField?.text,
            let moneyAmount = uint(stringAmount)
        else {
            return false
        }
        donationAmount = moneyAmount
        return true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func donateViaEthere(_ sender: Any) {
        if !validateInput() {
            showAlertWithMessage(title: "Please, enter valid info", message: nil)
        }
        let payment: IPayment = ETHPayment()
        let postPayment = PostPayment(recipient_ref: request.ref_id, amount: donationAmount)
        payment.pay(postPayment: postPayment, completion: { (error) in
//            guard error != nil else {
//                self?.showAlertWithMessage(title: "Error occured", message: error?.localizedDescription)
//                return
//            }
//            self?.showAlertWithMessage(title: "Congrats!", message: "Donation successfully accepted")
        })
        self.showAlertWithMessage(title: "Error occured", message: "Server error. Please, try again later")
    }
    
    @IBAction func donateViaIOTA(_ sender: Any) {
        showAlertWithMessage(title: "Unsupported operation", message: "Sorry, this payment is not supported yet")
    }
}
