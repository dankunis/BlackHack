//
//  CreateRequestViewController.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class CreateRequestViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var requestTitleTextField: UITextField!
    @IBOutlet weak var wantedAmountTextField: UITextField!
    @IBOutlet weak var requestDescriptionTextView: UITextView!
    
    // MARK: - Private fields
    
    var reqTitle: String = ""
    var reqWantedAmount: uint = 0
    var reqDescription: String = ""
    
    // MARK: - Private methods
    
    private func validateInput() -> Bool {
        guard
            let title = requestTitleTextField.text,
            let wantedAmountString = wantedAmountTextField.text,
            let wantedAmount = uint(wantedAmountString),
            let description = requestDescriptionTextView.text
        else {
            return false
        }
        reqTitle = title
        reqWantedAmount = wantedAmount
        reqDescription = description
        return true
    }
    
    private func showAlertWithMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func createMoneyRequestAction(_ sender: UIButton) {
        if !validateInput() {
            showAlertWithMessage(title: "Please, enter valid info", message: nil)
            return
        }
        let networkService = StorageService()
        let userHash = UserDefaults.standard.string(forKey: "userHash")!
        let post = MoneyRequest(title: reqTitle, description: reqDescription, wantedAmount: reqWantedAmount, currentAmount: 0, receiverRef: userHash)
        
        networkService.submitPost(post: post, completion: { [weak self] (error) in
            guard error != nil else {
                DispatchQueue.main.async {
                    self?.showAlertWithMessage(title: "Error occured", message: error?.localizedDescription)
                }
                return
            }
//            DispatchQueue.main.async {
//                self?.showAlertWithMessage(title: "Congrats!", message: "Request successfully saved")
//            }
        })
        self.showAlertWithMessage(title: "Congrats!", message: "Request successfully saved")
    }
}
