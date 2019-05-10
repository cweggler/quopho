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
    var quoteResult: QuoteResult?
    var image: FlickrImage?
    var flickrService = FlickrService()
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo"
        let url = image!.fullURL
        
         print(quoteResult ?? "not good") // for debugging purposes
        
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
        saveToCoreData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveQuopho" {
            // LOOK INTO WHAT DESTINATION YOU WANT
            //let destination = segue.destination as! QuophoViewController
        }
    }
    
    func saveToCoreData() {
        // Have to instantiate a QuotePhoto entity with NSManagedObjectContext
        let quopho = QuotePhoto(context: managedContext!)
        
        // get the attributes from the quote API
        let author = quoteResult!.quoteAuthor
        let text = quoteResult!.quoteText
        
        // get the attributes from the Flickr API
        let id = image!.photoData!.id
        let owner = image!.photoData!.owner
        let secret = image!.photoData!.secret
        let server = image!.photoData!.server
        let farm = image!.photoData!.farm
        let title = image!.photoData!.title
        let isPublic = image!.photoData!.ispublic
        
        // assign these quote attributes to the QuotePhoto entity
        quopho.quoteText = text
        quopho.quoteAuthor = author
        
        
        // assign these photo attributes to the QuotePhoto entity
        quopho.id = id
        quopho.owner = owner
        quopho.secret = secret
        quopho.server = server
        quopho.farm = Int32(farm)
        quopho.title = title
        quopho.ispublic = Int16(isPublic)
        
        do {
            try managedContext!.save()
        } catch {
            print("Error saving, \(error)")
        }
    }
}
