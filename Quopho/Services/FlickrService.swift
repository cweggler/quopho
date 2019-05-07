//
//  FlickrService.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation
import UIKit

// Alot of this taken from the NationalParkExplorer project
enum FlickrServiceError: Error {
    case RequestFailed
    case CouldNotParseResponse
    case ImageDownloadFailed
}

class FlickrService {
    
    // flickr's dev key, or you can try to get your own Dev key!
    // ENTER DEV KEY HERE
    let apiKey = "36dcfb03f3d16097235c90e2558338d4"
    
    func searchPhotos(query: String, completion: @escaping ([FlickrPhotoData]?, Error?) -> Void ) {
        
        let url = buildSearchURL(query: query)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let results = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(FlickrResponse.self, from: results)
                    completion(results.photos.photo, nil)
                } catch {
                    print(error) // good for debugging
                    completion(nil, FlickrServiceError.CouldNotParseResponse)
                }
            }
                
            else {
                print(error) // response error - for debugging
                completion(nil, FlickrServiceError.RequestFailed)
            }
        }
        task.resume()
    }
    
    
    
    func buildSearchURL(query: String) -> URL? {
        let components: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.flickr.com"
            components.path = "/services/rest"
            components.queryItems = [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "tags", value: query),
                URLQueryItem(name: "sort", value: "relevance"),
                URLQueryItem(name: "per_page", value: "40"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
            ]
            return components
        }()
        
        let url = components.url
        return url
    }
    
    
    func downloadImage(url: String, completion: @escaping (UIImage?, Error?) -> Void ) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            } else {
                print(error)
                completion(nil, FlickrServiceError.ImageDownloadFailed)
            }
        }
        task.resume() // very important.
    }
    
    
}

