//
//  ImageUpCloseViewController.swift
//  Quopho
//
//  Created by Cara on 5/8/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

class ImageUpCloseViewController: UIViewController {
    
    
    // to handle the Core Data you need a NSManagedObjectContext
    var managedContext: NSManagedObjectContext?
    var image: FlickrImage?
    var flickrService = FlickrService()
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo"
        let url = image!.fullURL
        
        // Ask app delegate for the persistentContainer. TODO: set this up in AppDelegate so not needed
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate!.persistentContainer.viewContext
        
        
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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // this is where you will save to CoreData
        
        let quopho = QuotePhoto(context: managedContext!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveQuopho" {
            let destination = segue.destination as! QuophoViewController
        }
    }
    
}
