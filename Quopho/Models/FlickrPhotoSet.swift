//
//  FlickrPhotoSet.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class FlickrPhotoSet {
    var photos: [FlickrPhotoData] // Made from the JSON data on the server
    var images: [FlickrImage]     // Image contains UIImage and a wrap UIImage objects for display
    
    let flickrService = FlickrService()
    
    init(photos: [FlickrPhotoData]) {
        self.photos = photos
        // sweet mapping that each data is mapped to its respective UIImage
        self.images = self.photos.map( { FlickrImage(photoData: $0) } )
    }
    
    func downloadThumbnailFor(index: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        let image = images[index]
        flickrService.downloadImage(url: image.thumbnailURL!, completion: { (image: UIImage?, error: Error? ) in
            self.images[index].thumbnail = image
            completion(image, error)
        })
    }
    
    var count: Int {
        return images.count
    }
    
    func photoAt(index: Int) -> FlickrPhotoData? {
        return photos[index]
    }
}
