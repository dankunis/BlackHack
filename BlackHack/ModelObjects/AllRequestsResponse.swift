//
//  AllRequestsResponse.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

struct AllRequestsResponse: Codable {
    let ref_id: String
    let body: MoneyRequest
}
