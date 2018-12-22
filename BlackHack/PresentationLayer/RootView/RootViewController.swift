//
//  RootViewController.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Black Hack"
    }

    // MARK: - IBActions
    
    @IBAction func createMoneyRequestAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CreateRequest", bundle: nil).instantiateInitialViewController() as? CreateRequestViewController {
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = "Create Request"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

