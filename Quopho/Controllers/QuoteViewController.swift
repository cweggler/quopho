//
//  QuoteViewController.swift
//  Quopho
//
//  Created by Cara on 5/3/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

// ViewController to show the data from Forismatic API

class QuoteViewController: UIViewController, QuoteDelegate {
    
    @IBOutlet var quoteTextView: UITextView!
    @IBOutlet var saveQuoteButton: UIButton!
    @IBOutlet var newQuoteButton: UIButton!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    
    var quoteResult: QuoteResult?
    let quoteService = ForismaticAPIService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Find a Quote"
        
        loadingIndicator.startAnimating()
        saveQuoteButton.isHidden = true
        newQuoteButton.isHidden = true
        
        quoteService.quoteDelegate = self
        quoteService.getRandomQuote()
    
    }
    
    @IBAction func newQuoteButtonTapped(_ sender: Any) {
        newQuoteButton.isEnabled = false
        loadingIndicator.startAnimating()
        quoteService.getRandomQuote()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "keepQuote" {
            let destination = segue.destination as! PhotoViewController
            destination.quoteResult = quoteResult
        }
    }
    
    
    func quoteFetched(quote: QuoteResult) {
        DispatchQueue.main.async {
            self.quoteResult = quote
            let quoteText = "<p>\(quote.quoteText)<p><em>\(quote.quoteAuthor)</em></p>"
            let data = Data(quoteText.utf8)
            
            
            let attributedString = try? NSAttributedString(
                data: data,
                options:
                [.documentType: NSAttributedString.DocumentType.html,
                 .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil)
            
            self.quoteTextView.attributedText = attributedString
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.saveQuoteButton.isHidden = false
            self.saveQuoteButton.isEnabled = true
            self.newQuoteButton.isHidden = false
            self.newQuoteButton.isEnabled = true
            
            
        }
    }
    
    func quoteFetchError(because quoteError: QuoteError) {
        let alert = UIAlertController(title: "Error", message: "Error fetching quote. \(quoteError.message)", preferredStyle: .alert)
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
        newQuoteButton.isHidden = false
    }
    
    
}
