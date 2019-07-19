//
//  APIManager.swift
//  SportHasten
//
//  Created by Juan Carlos Merlos Albarracín on 19/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation
import Reachability

class APIManager {
    
    static var model = [Sports]()
    var modelPlayers = [String: Any]()
    
    func getSports(completion: @escaping (_ weather: [Sports]?, _ error: Error?) -> Void) {
        fetchJSONFromURL(urlString: k.endpoint) { (data, error) in
            guard let data = data, error == nil else {
                print("ErrorData".localize)
                return completion(nil, error)
            }
            self.createSportsObjectWiht(json: data, completion: { (sport, error) in
                if let error = error {
                    print("ErrorConvertData".localize)
                    return completion(nil, error)
                }
                
                for item in sport ?? [Sports]() {
                    // Get model
                    APIManager.model.append(item)
                }
                return completion(sport, nil)
            })
        }
        
    }
    
}

extension APIManager {
    
    func fetchJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("ErrorCreateURL".localize)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let reachability = Reachability(), reachability.connection == .none {
            urlRequest.cachePolicy = .returnCacheDataDontLoad
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard error == nil else {
                print("ErrorCallApi".localize)
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("DataNil".localize)
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
        
    }
    
    private func createSportsObjectWiht(json: Data, completion: @escaping (_ data: [Sports]?, _ error: Error?) -> Void) {
        
        var jsonArray = APIManager.model
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonArray = try decoder.decode([Sports].self, from: json)
            
            return completion(jsonArray, nil)
            
        } catch let parsingError {
            print("Error".localize, parsingError.localizedDescription)
            return completion(nil, parsingError)
        }
        
    }
    
}
