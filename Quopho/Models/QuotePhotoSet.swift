//
//  QuotePhotoSet.swift
//  Quopho
//
//  Created by Cara on 5/14/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

// this lets the information in CoreData map to urls in Flickr to grab a UIImage

class QuotePhotoSet {
    var photoCoreData: [QuotePhoto] // QuotePhoto core data
    var images: [CoreDataImage]
    
    let flickrService = FlickrService()
    
    init(quopho: [QuotePhoto]) {
        self.photoCoreData = quopho
        
        //map each coreData photos only data to it's UIImage
        self.images = self.photoCoreData.map( { CoreDataImage(photoData: $0) } )
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
    
    func photoAt(index: Int) -> QuotePhoto? {
        return photoCoreData[index]
    }
}

