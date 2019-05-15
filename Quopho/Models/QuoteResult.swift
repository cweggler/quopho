//
//  QuoteResult.swift
//  Quopho
//
//  Created by Cara on 5/5/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation

// This is the class to contain the results from the Forismatic API

class QuoteResult: Decodable {
    
    let quoteText: String
    let quoteAuthor: String
    let senderName: String
    let senderLink: String
    let quoteLink: String
    
    // have to have init
    init(quoteText: String, quoteAuthor: String, senderName: String, senderLink: String, quoteLink: String) {
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
        self.senderName = senderName
        self.senderLink = senderLink
        self.quoteLink = quoteLink
    }
}
