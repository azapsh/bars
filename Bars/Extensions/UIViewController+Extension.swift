//
//  UIViewController+Extension.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import UIKit


extension UIViewController {
    
    func showAlert(title: String = "", _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
