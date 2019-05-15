//
//  QuoteDelegate.swift
//  Quopho
//
//  Created by Cara on 5/5/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation

// Delegate to hold functions that an object wishing to receive quotes
// or errors from fetching quotes must implement

protocol QuoteDelegate {
    func quoteFetched(quote: QuoteResult)
    func quoteFetchError(because quoteError: QuoteError)
}
