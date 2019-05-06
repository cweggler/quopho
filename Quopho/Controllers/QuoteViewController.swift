//
//  QuoteViewController.swift
//  Quopho
//
//  Created by Cara on 5/3/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

class QuoteViewController: UIViewController, NSFetchedResultsControllerDelegate, QuoteDelegate {
    
    
    //var managedContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func quoteFetched(quote: QuoteResult) {
        <#code#>
    }
    
    func quoteFetchError(because quoteError: QuoteError) {
        <#code#>
    }
    
}
