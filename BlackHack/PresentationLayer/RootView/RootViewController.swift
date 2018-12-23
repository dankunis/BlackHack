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
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        #imageLiteral(resourceName: "backgroundRoot").draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
    }

    // MARK: - IBActions
    
    @IBAction func createMoneyRequestAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CreateRequest", bundle: nil).instantiateInitialViewController() as? CreateRequestViewController {
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = "Create Request"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func donateMoneyAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "RequestsListView", bundle: nil).instantiateInitialViewController() as? RequestsListViewController {
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = "List of requests"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

