//
//  QuophoViewController.swift
//  Quopho
//
//  Created by Cara on 5/8/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

// ViewController that shows a larger Quote Photo (called quopho in this app) one at a time

class QuophoViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var managedContext: NSManagedObjectContext?
    //TODO: Add a way to delete a quopho from CoreData
    
    var coreDataImage: CoreDataImage?
    var text: String?
    var flickrService = FlickrService()
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        textView.text = text!
        
        let url = coreDataImage!.fullURL
        
        flickrService.downloadImage(url: url!) { (image: UIImage?, error: Error?) -> Void in

            DispatchQueue.main.async {

                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Error fetching photo "), animated: true)
                }
                else {
                    self.imageView.image = image
                }
            }
        }
        
    }
    
    @objc func deleteQuopho() {
    }
    
}
