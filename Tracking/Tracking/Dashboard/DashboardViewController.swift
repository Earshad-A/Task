//
//  DashboardViewController.swift
//  Tracking
//
//  Created by Earshad on 29/06/24.
//

import Foundation
import UIKit
import Combine

class DashboardViewController: UIViewController {
    @IBOutlet weak var userGreetLabel: UILabel!
    let viewModel = UserViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = LocationManager.shared
        self.navigationController?.navigationBar.isHidden = true
        getUserDetail()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        getUserDetail()
    }
    
    private func setupBindings() {
        viewModel.userChanged
            .receive(on: RunLoop.main)
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .signOut:
                    self.moveToLogin()
                case .changeUser:
                    self.getUserDetail()
                }
                
            }
            .store(in: &cancellables)
    }
    
    @IBAction func userClick(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        vc.viewModel = viewModel
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func trackClick(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationListViewController") as! LocationListViewController
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getUserDetail() {
        if let currentUser = viewModel.getCurrentUser() {
            userGreetLabel.text = "Hello, \(currentUser.username)!"
        } else {
            print("No logged-in user found")
        }
    }
    
    func moveToLogin() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([loginViewController], animated: true)
        }
    }
}
