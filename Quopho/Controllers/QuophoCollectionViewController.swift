//
//  QuophoCollectionViewController.swift
//  Quopho
//
//  Created by Cara on 5/3/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

class QuophoCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    var managedContext: NSManagedObjectContext?
    var fetchedQuophoController: NSFetchedResultsController<QuotePhoto>?
    var quophos: [QuotePhoto] = []
    
    //TODO: Set up a CollectionViewController that can load QuotePhoto entities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your Quopho Collection"
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true) // goes by id
        let quophoFetch = NSFetchRequest<QuotePhoto>(entityName: "QuotePhoto")
        quophoFetch.sortDescriptors = [sortDescriptor]
        
        fetchedQuophoController = NSFetchedResultsController<QuotePhoto>(fetchRequest: quophoFetch, managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedQuophoController?.delegate = self
        
        do {
            try fetchedQuophoController?.performFetch()
            quophos = fetchedQuophoController!.fetchedObjects!
        } catch {
            print("error fetching your quophos \(error)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let quopho = quophos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuophoCell", for: indexPath) as! QuophoCell
        
        // set the text
        cell.textView?.text = quopho.quoteText! + " " + quopho.quoteAuthor!
        
        // set the image
        //what does photoset.images do
        cell.imageView.image = UIImage(named: "Placeholder")
        
        return cell
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return the Quopho count
        return quophos.count
    }
    
    //prepare for segue
    
}

class PhotoCoreData {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int32
    let title: String
    let isPublic: Int16
    
    init(quopho: QuotePhoto) {
        self.id = quopho.id!
        self.owner = quopho.owner!
        self.secret = quopho.secret!
        self.server = quopho.server!
        self.farm = quopho.farm
        self.title = quopho.title!
        self.isPublic = quopho.ispublic
    }
}

class QuotePhotoSet {
    var photoCoreData: [PhotoCoreData] // Photodata from QuotePhoto core data
    var images: [FlickrImage]
    
    let flickrService = FlickrService()
    
    init(photoCoreData: [PhotoCoreData]) {
        self.photoCoreData = photoCoreData
        
        //map each coreData about photos to it's UIImage
        // realized this next statement DEPENDS on FlickrPhotoData because FlickrImage depends on FlickrPhotoData to initialize
        self.images = self.photoCoreData.map( { FlickrImage(photoData: $0) } )
        
    }
}
