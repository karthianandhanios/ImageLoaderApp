//
//  Platform.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import Foundation

public enum Result<T> {
    case Success(T)
    case Error(String)
}

public protocol RepositaryProvider {
   func searchImageForText(_ text: String, page : String, result : @escaping (Result<FilterResult>)-> Void)
}

class NetworkRepositary : RepositaryProvider {
     func searchImageForText(_ text: String, page : String, result : @escaping (Result<FilterResult>)-> Void) {
        var urlComponents = URLComponents(string: "https://api.flickr.com/services/rest/")!
        urlComponents.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "3e7cc266ae2b0e0d78e279ce8e361736"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "safe search", value: "1"),
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "page", value: page)
        ]
        let request = URLRequest(url: urlComponents.url!)
        let dataTask = URLSession.shared.dataTask(with:request) { data, response, error in
            if let error = error {
                result(.Error(error.localizedDescription))
                print("We got some error",error)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let gitData = try decoder.decode(FilterResult.self, from: data)
                    result(.Success(gitData))
                   
                } catch let err {
                     result(.Error(err.localizedDescription))
                     print("We got some error",err)
                }
            }
        }
        dataTask.resume()
    }
}

