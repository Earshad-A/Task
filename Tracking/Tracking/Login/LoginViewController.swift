//
//  ViewController.swift
//  Tracking
//
//  Created by Earshad on 06/07/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let vm = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }

    @IBAction func loginClick(_ sender: Any) {
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

        if vm.login(email: email, password: password) {
            print("Login successful")
            if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DashboardViewController") as? DashboardViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            locationScheduler.start()
        } else {
            self.showMessage(message: "User not found, Please register")
            print("Login failed")
        }

    }
    
    @IBAction func signUpClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

