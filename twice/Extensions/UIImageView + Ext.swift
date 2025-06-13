//
//  UIImageView + Ext.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 12/06/2025.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        // Check cache first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // Fetch from network
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            
            // Cache the image
            imageCache.setObject(image, forKey: urlString as NSString)
            
            // Set image on main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        dataTask.resume()
    }
}
