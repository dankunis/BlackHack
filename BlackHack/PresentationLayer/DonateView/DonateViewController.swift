//
//  DonateViewController.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    @IBOutlet weak var wantedAmmount: UILabel!
    @IBOutlet weak var currentAmount: UILabel!
    @IBOutlet weak var reqDescription: UILabel!
    @IBOutlet weak var insertAmountTextField: UITextField!
    
    public var request: AllRequestsResponse!
    
    private func configureUI() {
        reqDescription.text = request.body.description
        wantedAmmount.text = String(request.body.wantedAmount)
        currentAmount.text = String(request.body.currentAmount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateViaEthere(_ sender: Any) {
        let payment: IPayment = ETHPayment()
        payment.pay(hash: "dsad", completion: {_ in})
    }
    
    @IBAction func donateViaIOTA(_ sender: Any) {
    }
}
