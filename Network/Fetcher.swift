//
//  Fetcher.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 25/02/21.
//

import Foundation

class Fetcher<T: Decodable>{
    
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(T)
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
    }
    
    
    func fetchList(withURL url: String,onComplition:@escaping ([T])-> Void) {
        
        let mainURL = URL(string: url)
        URLSession.shared.dataTask(with: URLRequest(url: mainURL!)) { (data,respsne,error) in
            guard let jsonData = data else { print("\(String(describing: error))")
                onComplition([])
                return
            }
            let decoder = JSONDecoder()
            let result = try? decoder.decode([T].self, from: jsonData)
            onComplition(result ?? [])
        }.resume()
    
    }
}
