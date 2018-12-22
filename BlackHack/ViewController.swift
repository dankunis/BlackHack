//
//  ViewController.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkService()
        
        let post = PostMoneyRequest(title: "maxim is a fool")
        
        networkService.submitPost(post: post, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

