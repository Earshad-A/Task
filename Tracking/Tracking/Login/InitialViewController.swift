//
//  InitialViewController.swift
//  Tracking
//
//  Created by Earshad on 07/07/24.
//

import UIKit

class InitialViewController: UIViewController {
    let userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        if userViewModel.getCurrentUser() != nil {
            print("Logged in user")
            let dashboardViewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            if let navigationController = self.navigationController {
                navigationController.setViewControllers([dashboardViewController], animated: true)
            }
        } else {
            print("No user")
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigationController = self.navigationController {
                navigationController.setViewControllers([loginViewController], animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
