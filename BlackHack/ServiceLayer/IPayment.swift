//
//  IPayment.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

protocol IPayment {
    
    func pay(postPayment: PostPayment, completion: @escaping ((Error?) -> Void))
}
