//
//  DogApiHelper.swift
//  WebServices-iOS
//
//  Created by Tajamal on 10/03/2022.
//

import Foundation

import UIKit

enum path: String{
    case allBreeds = "breeds/list/all"
    case randomImages = "/images/random"
}


//https://dog.ceo/api/breed/-------/images/random

struct DogAPIHelpers {
    static private let baseURL = "https://dog.ceo/api/"
    
    static private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetchBreeds(completionHandler: @escaping ([String:[String]]) -> Void){
        let url = URL(string: baseURL + path.allBreeds.rawValue)!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionary = jsonObject as? [AnyHashable:Any],
                        let breed = jsonDictionary["message"] as? [String:[String]]
                    else {
                        preconditionFailure("could not parse json data")
                    }
                                        
                    OperationQueue.main.addOperation {
                        completionHandler(breed)
                    }
                    
                        
                    
                } catch let error {
                    print("error \(error)")
                }

            }
        }
        task.resume()
    }
    
    
    
    
    static func fetchBreedImage(breed: String, subbreed: String = "", completion: @escaping (UIImage) -> Void){
        let url = URL(string: baseURL + "breed/" + breed + subbreed + path.randomImages.rawValue)!
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionary = jsonObject as? [AnyHashable:Any],
                        let imageURL = jsonDictionary["message"] as? String
                    else{
                        preconditionFailure("could not parse image response")
                    }
                    
                    if let imageURL = URL(string: imageURL){
                        fetchImage(url: imageURL) { imageData in
                            OperationQueue.main.addOperation {
                                completion(imageData)
                              
                            }
                        }
                    } else {
                        preconditionFailure("url could not be constructed \(imageURL)")
                    }

            
                } catch let error {
                    print("error \(error)")
                }

            }
        }
        task.resume()
    }
    static private func fetchImage(url: URL, completion: @escaping (UIImage) -> Void){
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                if let image = UIImage(data: data){
                    completion(image)
                } else {
                    preconditionFailure("image could not be properly converted")
                }
            }
        }
        task.resume()

    }
    
}
