//
//  QuophoViewController.swift
//  Quopho
//
//  Created by Cara on 5/8/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

class QuophoViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var managedContext: NSManagedObjectContext?
    //TODO: Add a way to delete a quopho from CoreData
    //var fetchedQuophoController: NSFetchedResultsController<QuotePhoto>?
    //var quophos: [QuotePhoto] = []
    var coreDataImage: CoreDataImage?
    var text: String?
    var flickrService = FlickrService()
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    
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
        
//        let quophoFetch = NSFetchRequest<QuotePhoto>(entityName: "QuotePhoto")
//        fetchedQuophoController = NSFetchedResultsController<QuotePhoto>(fetchRequest: quophoFetch, managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)
//
//        fetchedQuophoController?.delegate = self
    }
    
    //TODO: Add a way to delete a quopho from CoreData
    // Use navigationController!.popViewController(animated: true) for going back
    @IBAction func deleteQuopho(_ sender: Any) {
//        do {
//            //managedContext!.delete(quopho)
//            //try managedContext!.save()
//        } catch {
//
//        }
   }
    
//    func getQuopho() {
//        do {
//            try fetchedQuophoController?.performFetch()
//            quophos = fetchedQuophoController!.fetchedObjects!
//            
//        } catch {
//            print("error fetching your quopho \(error)")
//        }
//    }
    
    
    
}
