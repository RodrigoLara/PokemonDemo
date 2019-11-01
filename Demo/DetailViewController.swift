//
//  DetailViewController.swift
//  Demo
//
//  Created by Rodrigo Lara on 10/31/19.
//  Copyright © 2019 Kingtide. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var pokemonName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        loadingView.layer.cornerRadius = 8

        loadData()
    }
    
    func loadData() {
        guard let name = pokemonName else { return }
        
        showLoading()
        
        APIRequest.retriveData(endpoint: "pokemon/\(name)/") { (response) in
            self.stopLoading()
            
            if response.response?.statusCode == 200 {
                if let data = response.value as? NSDictionary {
                    let pokemon = Pokemon(withDic: data)
                    
                    self.id.text = "#\(pokemon.id)"
                    self.name.text = pokemon.name
                    self.weight.text = pokemon.weight.description
                    self.height.text = pokemon.height.description
                    
                    guard let url = URL(string: pokemon.image) else { return }
                    let imageData = try! Data(contentsOf: url)
                    
                    self.image.image = UIImage(data: imageData)
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
