//
//  RequestsListViewController.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import UIKit

class RequestsListViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var requestsTableView: UITableView!
    
    // Dependencies
    
    let networkService = StorageService()
    
    // MARK: - Private properties
    
    private let identifier = String(describing: RequestTableViewCell.self)
    
    private var requests: [AllRequestsResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestsTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        requestsTableView.dataSource = self
        requestsTableView.delegate = self
        
        requestsTableView.rowHeight = 70
        requestsTableView.isHidden = true
        activityIndicator.startAnimating()
        networkService.getAllRequests { [weak self] (requests, error) in
            guard error == nil, let requests = requests else {
                fatalError()
            }
            self?.requests = requests
            print("All requests: \(requests)")
            DispatchQueue.main.async {
                self?.requestsTableView.reloadData()
                self?.requestsTableView.isHidden = false
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension RequestsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? RequestTableViewCell else {
            return UITableViewCell()
        }
        
        let request = requests[indexPath.row].body
        
        cell.configure(with: request)
        
        return cell
    }
}

extension RequestsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard (tableView.cellForRow(at: indexPath) as? RequestTableViewCell) != nil else {
            return
        }
        
        let request = requests[indexPath.row]
        
        if let vc = UIStoryboard(name: "DonateView", bundle: nil).instantiateInitialViewController() as? DonateViewController {
            vc.navigationItem.largeTitleDisplayMode = .always
            vc.request = request
            vc.title = request.body.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
