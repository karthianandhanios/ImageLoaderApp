//
//  Photos.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import Foundation

public struct Photo: Codable {
    
    let id : String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic : Int
    let isfriend : Int
    let isfamily : Int
}


public struct Photos : Codable {
    let page : Int
    let pages : Int
    let perpage : Int
    let total : String
    let photo : [Photo]
}

public struct FilterResult : Codable {
    let photos : Photos
    let stat : String
}
