//
//  IPayment.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

protocol IPayment {
    
    func pay(hash: String, completion: @escaping ((Error?) -> Void))
}
