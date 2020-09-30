//
//  UIImage+extensions.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import Foundation
import UIKit

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
