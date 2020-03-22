//
//  RestService.swift
//  COVID-19 Stats
//
//  Created by boburcho on 21/03/2020.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class RestService {
    
    static var shared = RestService()
    
    func fetchGenericData<T:Decodable>(_ url: String, httpMethod: HTTPMethod, completion: @escaping (T) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
//        example to JWT token
//        request.setValue("AD234234SADSASDadsasd", forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
                print(error)
            }
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(T.self, from: data)
                completion(course)
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
    
    func fetchImage(linkToImage: String, image: UIImageView) {
        
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(from url: URL) {
            
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                    image.image = UIImage(data: data)
            }
        }
        
        guard let url = URL(string: linkToImage) else { return }
        downloadImage(from: url)
    }
}


import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
