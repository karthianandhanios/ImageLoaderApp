//
//  ImageSearchUsecase.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import Foundation

public protocol ContactsUseCaseProvider {
    func searchImageForText(_ text: String, page : String, result : @escaping (FilterResult)-> Void)
}

class ContactsUseCase : ContactsUseCaseProvider {
    let platformProvider : RepositaryProvider
    init( platform : RepositaryProvider) {
        self.platformProvider = platform
    }
    func searchImageForText(_ text: String, page : String, result : @escaping (FilterResult)-> Void) {
        platformProvider.searchImageForText(text, page: page, result: {
            response in
            result(response)
        })
    }
}
