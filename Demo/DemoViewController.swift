//
//  DemoViewController.swift
//  Demo
//
//  Created by Rodrigo Lara on 10/31/19.
//  Copyright © 2019 Kingtide. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    @IBOutlet weak var demoTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var demoArray: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Demo"
        loadingView.layer.cornerRadius = 8
        
        demoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DemoCell")

        loadData()
    }
    
    func loadData() {
        showLoading()
        
        APIRequest.retriveData(endpoint: "pokemon") { (response) in
            self.stopLoading()
            
            if response.response?.statusCode == 200 {
                if let data = response.value as? NSDictionary {
                    if let results = data["results"] as? NSArray {
                        self.demoArray = results
                        
                        self.demoTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func showLoading() {
        loadingView.isHidden = false
        activityView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.isHidden = true
        activityView.stopAnimating()
    }
}

extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let demoCell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        
        if let data = demoArray[indexPath.row] as? NSDictionary {
            demoCell.textLabel?.text = data["name"] as? String
            demoCell.accessoryType = .disclosureIndicator
        }
        
        return demoCell
    }
}

extension DemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        if let data = demoArray[indexPath.row] as? NSDictionary {
            detailViewController.pokemonName = data["name"] as? String
        }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
