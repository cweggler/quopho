//
//  QuoteError.swift
//  Quopho
//
//  Created by Cara on 5/5/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation

class QuoteError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
