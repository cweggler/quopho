//
//  PhotoViewController.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var quoteResult: QuoteResult?
    let reuseIdentifier = "photoCell"
    var searchTerm = "nature"
    
    // global variable to retrieve data properly
    var photoSet: FlickrPhotoSet?
    
    //retrieve data from the API
    let flickrservice = FlickrService()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Find a photo"
        
        flickrservice.searchPhotos(query: searchTerm) { ( photos: [FlickrPhotoData]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                if error != nil {
                    self.present(ErrorAlertController.alert(message: "Unable to fetch photos"), animated: true)
                }
                
                if let photos = photos {
                    if photos.count == 0 {
                        self.present(ErrorAlertController.alert(message: "No photos found, try another park?"), animated: true)
                    }
                    else {
                        print(photos)
                        self.photoSet = FlickrPhotoSet(photos: photos) //initialize
                        self.collectionView.reloadData() //tells collectionview to reload to display the photos
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSet?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        // if already thumbnail, set and return
        // else if no thumbnail, set placeholder, initiate request
        // the completion handler will refresh the cell once image is downloaded
        
        guard let photoSet = photoSet else {
            cell.image.image = UIImage(named: "placeholder")
            return cell
        }
        
        if let thumbnail = photoSet.images[indexPath.row].thumbnail {
            cell.image.image = thumbnail
        }
            
        else {
            cell.image.image = UIImage(named: "placeholder")
            requestThumbnail(for: indexPath.row)
        }
        
        return cell
    }
    
    func requestThumbnail(for index: Int) {
        let imageData = self.photoSet?.images[index]
        
        flickrservice.downloadImage(url: imageData!.thumbnailURL!) { (thumbnail: UIImage?, error: Error?) in self.photoSet?.images[index].thumbnail = thumbnail
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
    
    
}
