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
    var qPhotoSet: QuotePhotoSet?
    // another way to deal with images in CoreData for next time instead of QuotePhotoSet
    // is to save a file name to CoreData and use the FileManager to save/retrieve the image
    
    let flickrservice = FlickrService()
    
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
            self.qPhotoSet = QuotePhotoSet(quopho: quophos)
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
        guard let qPhotoSet = qPhotoSet else {
            cell.imageView.image = UIImage(named: "Placeholder")
            return cell
        }
        
        if let thumbnail = qPhotoSet.images[indexPath.row].thumbnail {
            cell.imageView.image = thumbnail
        }
        
        else {
            cell.imageView.image = UIImage(named: "Placeholder")
            requestThumbnail(for: indexPath.row)
        }

        return cell
   }
    
    func requestThumbnail(for index: Int) {
        let imageData = self.qPhotoSet?.images[index]
        
        flickrservice.downloadImage(url: imageData!.thumbnailURL!) { (thumbnail: UIImage?, error: Error?) in
            self.qPhotoSet?.images[index].thumbnail = thumbnail
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return the Quopho count
        return quophos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuopho" {
            let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row
            let selectedImage = qPhotoSet!.images[selectedIndex!]
            let selectedQuote = quophos[selectedIndex!].quoteText! + " -" + quophos[selectedIndex!].quoteAuthor!
            let destination = segue.destination as! QuophoViewController
            destination.managedContext = managedContext
            destination.coreDataImage = selectedImage
            destination.text = selectedQuote
        }
    }
}


