//
//  Utility.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() {
                self.image = cachedImage
            }
        }else{
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    
                    else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() {
                    self.image = image
                }
                }.resume()
        }
        
        
        
    }
    
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  
        guard let url = URL(string: link ?? "") else { return }
        downloaded(from: url, contentMode: mode)
    }
}


struct UITitle {
    static let empty =  "There is no photos with key \""
    static let typeSomthing =  "Type something to search!"
    static let placeHolder = "Your placeholder"
    static let somethingWrong = "Something went wrong!"
}
