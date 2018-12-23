//
//  PostPayment.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct PostPayment: Codable {
    let recipient_ref: String
    let amount: uint
}
