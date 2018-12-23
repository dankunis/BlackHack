//
//  RequestTableViewCell.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

protocol IRequestTableViewCell {
    var title: String {get set}
    var reqDescription: String {get set}
    var wantedAmount: uint {get set}
    var currentAmount: uint {get set}
    var receiverRef: String {get set}
}

class RequestTableViewCell: UITableViewCell, IRequestTableViewCell {
    
    var title: String = "" {
        didSet {
            requestTitle.text = title
        }
    }
    
    var reqDescription: String = "" {
        didSet {
            requestDescription.text = reqDescription
        }
    }
    
    var wantedAmount: uint = 0 {
        didSet {
            if currentAmount == 0 {
                progressPercentage.text = "0%"
            } else {
                progressPercentage.text = String(Int((wantedAmount / currentAmount)*100)) + "%"
            }
        }
    }
    var currentAmount: uint = 0 {
        didSet {
            if currentAmount == 0 {
                progressPercentage.text = "0%"
            } else {
                progressPercentage.text = String(Int((wantedAmount / currentAmount)*100)) + "%"
            }
        }
    }
    var receiverRef: String = ""
    
    @IBOutlet weak var requestTitle: UILabel!
    @IBOutlet weak var requestDescription: UILabel!
    @IBOutlet weak var progressPercentage: UILabel!

    func configure(with moneyRequest: MoneyRequest) {
        title = moneyRequest.title
        reqDescription = moneyRequest.description
        wantedAmount = moneyRequest.wantedAmount
        currentAmount = moneyRequest.currentAmount
        receiverRef = moneyRequest.receiverRef
        if currentAmount == 0 {
            progressPercentage.text = "0%"
        } else {
            progressPercentage.text = String(Int((wantedAmount / currentAmount)*100)) + "%"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
