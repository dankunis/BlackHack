//
//  ETHPayment.swift
//  BlackHack
//
//  Created by Daniel on 23/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

class ETHPayment: IPayment {
    func pay(hash: String, completion: @escaping ((Error?) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "test.stax.tlabs.cloud"
        urlComponents.port = 443
        urlComponents.path = "/projects/shahmadidan2/contexts/test/payment"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["accept"] = "application/json"
        headers["Originator-Ref"] = UserDefaults.standard.string(forKey: "userHash")!
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = UserDefaults.standard.string(forKey: "userPrivateKey")
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(PostPayment(ref_id: hash))
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
}
