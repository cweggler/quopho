//
//  ImageUpCloseViewController.swift
//  Quopho
//
//  Created by Cara on 5/8/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class ImageUpCloseViewController: UIViewController {
    
    var image: FlickrImage?
    var flickrService = FlickrService()
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo"
        
        let url = image!.fullURL
        
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
}
