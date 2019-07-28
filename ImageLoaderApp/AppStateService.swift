//
//  AppStateService.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import Foundation

class AppStateService: NSObject {
    static let shared = AppStateService()
    let imageSearchUseCaseProvider :  ContactsUseCaseProvider
    private override init() {
        imageSearchUseCaseProvider = ContactsUseCase(platform:NetworkRepositary())
    }
}
