//
//  UImageView+Extensions.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to newSize: CGSize, tintColor: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { (context) in
            let tintedImage = self.withTintColor(tintColor)
            tintedImage.draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image
    }
}
