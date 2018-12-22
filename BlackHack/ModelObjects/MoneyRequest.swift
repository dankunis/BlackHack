//
//  Post.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct MoneyRequest: Codable {
    let title: String
    let description: String
    let wantedAmount: uint
    let currentAmount: uint
    let receiverRef: String
}
