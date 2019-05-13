//
//  CoreDataImage.swift
//  Quopho
//
//  Created by Cara on 5/12/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import CoreData

class CoreDataImage {
    var photoData: QuotePhoto?
    var thumbnail: UIImage?
    var full: UIImage?
    
    init(photoData: QuotePhoto) {
        self.photoData = photoData
    }
    
    var thumbnailURL: String? {
        guard let corePhoto = photoData else { return nil }
        return "https://farm\(corePhoto.farm).staticflickr.com/\(corePhoto.server!)/\(corePhoto.id!)_\(corePhoto.secret!)_q.jpg"
    }
    
    var fullURL: String? {
        guard let corePhoto = photoData else { return nil }
        return "https://farm\(corePhoto.farm).staticflickr.com/\(corePhoto.server!)/\(corePhoto.id!)_\(corePhoto.secret!)_b.jpg"
    }
    
    
}
