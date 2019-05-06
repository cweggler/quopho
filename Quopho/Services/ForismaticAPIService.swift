//
//  ForismaticAPIService.swift
//  Quopho
//
//  Created by Cara on 5/5/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation
import UIKit

class ForismaticAPIService {
    
    var quoteDelegate: QuoteDelegate?
    
    //TODO: figure out URL components if you can
    let urlString = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"
    
    func getRandomQuote() {
        guard let delegate = quoteDelegate else {
            print("Warning- no delegate set")
            return
        }
        
        let url = URL(string: urlString)
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) in
            if let error = error {
                delegate.quoteFetchError(because: QuoteError(message: error.localizedDescription))
            }
            
            if let quoteData = data {
                let decoder = JSONDecoder()
                do {
                    let quoteResult = try decoder.decode(QuoteResult.self, from: quoteData)
                     delegate.quoteFetched(quote: quoteResult)
                }
                catch {
                    delegate.quoteFetchError(because: QuoteError(message: "No quotes returned"))
                }
            }
            else {
                delegate.quoteFetchError(because: QuoteError(message: "Unable to decode response from quote server"))
            }
        })
        
        task.resume() // SUPER important, starts the data task and makes the API request
        
    }
    
}
