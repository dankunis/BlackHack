//
//  CreateRequestViewController.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class CreateRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func createMoneyRequestAction(_ sender: UIButton) {
        let networkService = NetworkService()
        
        let post = PostMoneyRequest(title: "Test", description: "I need money", categories: ["Business"], wantedAmount: 1000, currentAmount: 0)
        
        networkService.submitPost(post: post, completion: { [weak self] (error) in print(error?.localizedDescription)})
    }
}
