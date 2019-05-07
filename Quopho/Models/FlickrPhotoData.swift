//
//  FlickrPhotoData.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation
import UIKit

struct FlickrResponse: Decodable {
    let photos: FlickrPhotoResponse
}

struct FlickrPhotoResponse: Decodable {
    let photo: [FlickrPhotoData]
}

struct FlickrPhotoData: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
}
