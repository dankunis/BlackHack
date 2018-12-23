//
//  StorageService.swift
//  BlackHack
//
//  Created by Daniel on 22/12/2018.
//  Copyright © 2018 Daniel. All rights reserved.
//

import Foundation

class StorageService {
    
    private func getAllUsersHashes(completion: @escaping ([String]?,Error?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "test.stax.tlabs.cloud"
        urlComponents.port = 443
        urlComponents.path = "/projects/shahmadidan2/contexts/test/account"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["accept"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion(nil, responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if
                let data = responseData,
                let utf8Representation = String(data: data, encoding: .utf8),
                let parsedHashes = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                print("response: ", utf8Representation)
                completion(parsedHashes, nil)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
//    private func getAllRequestsForUser(userHash: String, completion: @escaping ([MoneyRequest]?, Error?) -> Void) {
//        print("gege")
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "test.stax.tlabs.cloud"
//        urlComponents.port = 443
//        urlComponents.path = "/projects/shahmadidan2/contexts/test/storage"
//        urlComponents.queryItems = [URLQueryItem(name: "fields", value: "body")]
//        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
//        // Specify this request as being a POST method
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        // Make sure that we include headers specifying that our request's HTTP body
//        // will be JSON encoded
//        var headers = request.allHTTPHeaderFields ?? [:]
//        headers["accept"] = "*/*"
//        headers["Originator-Ref"] = userHash
//        request.allHTTPHeaderFields = headers
//
//        // Create and run a URLSession data task with our JSON encoded POST request
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//            guard responseError == nil else {
//                completion(nil, responseError)
//                return
//            }
//
//            // APIs usually respond with the data you just sent in your POST request
//            if
//                let data = responseData,
//                let utf8Representation = String(data: data, encoding: .utf8),
//                let requests = try? JSONDecoder().decode(GetAllRequestsResponse.self, from: data) {
//                print("requests: ", requests)
//            } else {
//                print("no readable data received in response")
//            }
//        }
//        task.resume()
//    }
    
    func getAllRequests(completion: @escaping ([AllRequestsResponse]?, Error?) -> Void) {
        getAllUsersHashes { (hashes, error) in
            guard
                error == nil,
                let hashes = hashes
            else {
                print(error?.localizedDescription ?? "error ocured while getting all hashes")
                return
            }
            var allRequests: [AllRequestsResponse] = []
            for hash in hashes {
//                self?.getAllRequestsForUser(userHash: hash, completion: { (requests, error) in })
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "test.stax.tlabs.cloud"
                urlComponents.port = 443
                urlComponents.path = "/projects/shahmadidan2/contexts/test/storage"
                urlComponents.queryItems = [URLQueryItem(name: "fields", value: "body")]
                guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
                // Specify this request as being a POST method
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                // Make sure that we include headers specifying that our request's HTTP body
                // will be JSON encoded
                var headers = request.allHTTPHeaderFields ?? [:]
                headers["accept"] = "*/*"
                headers["Originator-Ref"] = hash
                request.allHTTPHeaderFields = headers
                
                // Create and run a URLSession data task with our JSON encoded POST request
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let task = session.dataTask(with: request) { (responseData, response, responseError) in
                    guard responseError == nil else {
                        return
                    }
                    
                    // APIs usually respond with the data you just sent in your POST request
                    if
                        let data = responseData,
                        let utf8Representation = String(data: data, encoding: .utf8),
                        let requests = try? JSONDecoder().decode([AllRequestsResponse].self, from: data) {
                        print("requests: ", utf8Representation)
                        for request in requests {
                            allRequests.append(request)
                        }
                    } else {
                        print("no readable data received in response")
                    }
                    completion(allRequests, nil)
                }
                task.resume()
            }
        }
        
    }
    
    func generateAccount(newAccount: AccountCreator, completion: @escaping (Error?) -> Void) -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "test.stax.tlabs.cloud"
        urlComponents.port = 443
        urlComponents.path = "/projects/shahmadidan2/contexts/test/account"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(newAccount)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion(error)
        }
        
        var userHash: String = ""
        
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
                userHash = utf8Representation
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
        guard userHash != "" else {
            fatalError()
        }
        return userHash
    }
    
    func submitPost(post: MoneyRequest, completion: @escaping ((Error?) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "test.stax.tlabs.cloud"
        urlComponents.port = 443
        urlComponents.path = "/projects/shahmadidan2/contexts/test/storage"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["accept"] = "*/*"
        headers["Originator-Ref"] = UserDefaults.standard.string(forKey: "userHash")!
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
         
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)
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
