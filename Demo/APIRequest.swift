//
//  APIRequest.swift
//  Demo
//
//  Created by Rodrigo Lara on 10/31/19.
//  Copyright © 2019 Kingtide. All rights reserved.
//

import Foundation
import Alamofire

public class APIRequest {
    static let baseURL = "https://pokeapi.co/api/v2/"
    
    private class func createRequest(_ endpoint: String) -> URL? {
        guard let urlRequest = URL(string: "\(baseURL)\(endpoint)") else { return nil }
        
        return urlRequest
    }
    
    public class  func retriveData(endpoint: String, result: @escaping (AFDataResponse<Any>) -> Void) {
        guard let request = createRequest(endpoint) else { return }
        
        AF.request(request).responseJSON { (response) in
            result(response)
        }
    }
}
