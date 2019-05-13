//
//  ViewController.swift
//  Quopho
//
//  Created by Cara on 4/23/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func createNew(_ sender: Any) {
    }
    
    @IBAction func seeCreations(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNew" {
            _ = segue.destination as! QuoteViewController
        }
        else if segue.identifier == "seeCollection" {
            _ = segue.destination as! QuophoCollectionViewController
            //TODO: Set up managedContext
        }
        else {
            print("What type of segue is this?")
        }
    }
    

}

