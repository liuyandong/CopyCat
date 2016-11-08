//
//  Extensions.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 9/21/16.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithVisualFormat(format: String, views: UIView...) {
        
        var viewsDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options:NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var originalUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        originalUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data:data!)
                
                if (self.originalUrlString == urlString) {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
            
        }).resume()
    }
    
}
