//
//  PhotoViewController.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//
// Got some help implementing Searchbar functionality from
// https://github.com/SheldonWangRJT/iOS-Swift4-SearchBar-TableView-iPhoneX/blob/master/SearchBarInTable/SearchBarInTable/ViewController.swift
// ViewController to show the photos from Flickr

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // delegate method like Willdisplaycell, check if the index path is the last, and then fetch new for infinite scroll. collectView.reloadData
    var quoteResult: QuoteResult? // need to instantiate this
    let reuseIdentifier = "UIImageCollectionViewCell"
    var searchTerm = "nature"
    
    //This adds the searchBar for further customization
    @IBOutlet var searchBar: UISearchBar!
    
    //TODO: Add the ability to scroll so it shows more pictures
    
    // global variable to retrieve data properly
    var photoSet: FlickrPhotoSet?
    
    //retrieve data from the API
    let flickrservice = FlickrService()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Find a photo"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Nature"
        searchPhotos()
        
    }
    
    func searchPhotos() {
        flickrservice.searchPhotos(query: searchTerm) { ( photos: [FlickrPhotoData]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                if error != nil {
                    self.present(ErrorAlertController.alert(message: "Unable to fetch photos"), animated: true)
                }
                
                if let photos = photos {
                    if photos.count == 0 {
                        self.present(ErrorAlertController.alert(message: "No photos found, try entering another search term?"), animated: true)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchTerm != "" {
            searchPhotos()
            searchBar.resignFirstResponder()
        } else {
            searchTerm = "nature"
            searchPhotos()
            searchBar.resignFirstResponder()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row
            let selectedImage = photoSet!.images[selectedIndex!]
            let destination = segue.destination as! ImageUpCloseViewController
            destination.image = selectedImage
            destination.quoteResult = quoteResult
            
        }
    }
    
    
}
