//
//  extensions.swift
//  Tracking
//
//  Created by Earshad on 06/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            alertController.dismiss(animated: true, completion: nil)
           })
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+){1,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@",emailRegEx)
        let result = emailTest.evaluate(with: (testStr))
        return result
    }
}

extension UIView {
    func boxShadow(){
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 1.5
    }
}

extension UIButton {
    func styleButton() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.setTitleColor(.darkGray, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        self.layer.shadowRadius = 1.5
        self.layer.masksToBounds = false
    }
}
