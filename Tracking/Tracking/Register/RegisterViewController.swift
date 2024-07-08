//
//  RegisterViewController.swift
//  Tracking
//
//  Created by Earshad on 06/07/24.
//

import Foundation

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    let vm = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.title = "Register"
    }
    
    @IBAction func registerClick(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            self.showMessage(message: "Enter email")
            return
        }
        
        if !self.isValidEmail(testStr: email) {
            self.showMessage(message: "Enter valid email")
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.showMessage(message: "Enter password")
            return
        }
        
        guard let username = userNameTextField.text, !username.isEmpty else {
            self.showMessage(message: "Enter password")
            return
        }
        
        if vm.signUp(email: email, password: password, username: username) {
            print("Register successful")
            if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DashboardViewController") as? DashboardViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.showMessage(message: "Something went wrong... :/")
        }
        
    }
    
    @IBAction func loginClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
