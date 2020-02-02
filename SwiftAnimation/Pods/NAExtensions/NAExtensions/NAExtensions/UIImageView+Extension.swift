//
//  UIImageView+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

public extension UIImageView {
    
    // download the image from image url string.
    func downloadImage(urlString: String) -> Void {
        
        if urlString.isEmpty { return }
        
        self.image = nil
        
        // if image is cached of this url string, fetch the cached image.
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        // send request to download the image from url.
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) {data, response, error in
            if error != nil { return }
            DispatchQueue.main.async {
                let downloadedImage = UIImage(data: data!)
                if let image = downloadedImage {
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    self.image = UIImage(data: data!)
                }
            }
        }
        dataTask.resume()
    }
    
    // to add the black gradient from bottom to top.
    func addBlackGradient(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.locations = [0.5, 1.0]
        gradient.colors = colors.map({$0.cgColor})
        self.layer.addSublayer(gradient)
    }
}
