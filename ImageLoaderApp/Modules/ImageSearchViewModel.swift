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

class ImageSearchViewModel  {
    var searchText : String?
    var imageSearchResult : [PhotoData] = []
    var currentPage = 0
    var maxPage = 1
    
    func searchImage(for text: String, completion : @escaping ()->Void)  {
        if searchText != text{
            imageSearchResult = []
        }
        searchText =  text
        //TODO: avoid calling this 2-3 times
        if self.currentPage < self.maxPage {
            AppStateService.shared.imageSearchUseCaseProvider.searchImageForText(text, page: String(self.currentPage + 1), result: {
                response in
                self.parseData(response: response)
                self.currentPage = response.photos.page
                self.maxPage   = response.photos.pages
                completion()
            })
        }else{
            completion()
        }
    }
    
    private func parseData(response : FilterResult){
        var images : [PhotoData] = imageSearchResult
        response.photos.photo.map{
            let imageUrl = "https://farm" + String($0.farm) + ".static.flickr.com/" + $0.server + "/" + $0.id + "_" + $0.secret + ".jpg"
            let photo = PhotoData.init(id: $0.id, imageUrl: imageUrl)
            images.append(photo)
        }
        imageSearchResult = images
    }
}
