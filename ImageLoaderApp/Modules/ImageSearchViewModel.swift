//
//  ImageSearchViewModel.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import Foundation

struct PhotoData  {
     let id : String
     let imageUrl : String
}

enum Response{
    case Success
    case Error(String)
}

class ImageSearchViewModel  {
    var searchText : String?
    var imageSearchResult : [PhotoData] = []
    var currentPage = 0
    var maxPage = 1
    
    func searchImage(for text: String, completion : @escaping (Response,String)->Void)  {
        if searchText != text{
            imageSearchResult = []
            currentPage = 0
            maxPage = 1
        }
        searchText =  text
        //TODO: avoid calling this 2-3 times
        if self.currentPage < self.maxPage {
            AppStateService.shared.imageSearchUseCaseProvider.searchImageForText(text, page: String(self.currentPage + 1), result: {
                response in
                switch response {
                case .Success(let data):
                    self.currentPage = data.photos.page
                    self.maxPage   = data.photos.pages
                    if data.photos.photo.count > 0 {
                        self.parseData(response: data,isPagination: data.photos.page > 1)
                        completion(.Success,text)
                    }else{
                        let empty  = UITitle.empty + text + "\""
                        completion(.Error(empty), text)
                    }
                    
                case .Error(let msg):
                    completion(.Error(msg),text)
                }
            })
        }else{
            completion(.Error(""),text)
       }
    }
    
    private func parseData(response : FilterResult, isPagination : Bool){
        var images : [PhotoData] = []
        if isPagination {
            images = imageSearchResult
        }
        response.photos.photo.map{
            let imageUrl = "https://farm" + String($0.farm) + ".static.flickr.com/" + $0.server + "/" + $0.id + "_" + $0.secret + ".jpg"
            let photo = PhotoData.init(id: $0.id, imageUrl: imageUrl)
            images.append(photo)
        }
        imageSearchResult = images
    }
}
