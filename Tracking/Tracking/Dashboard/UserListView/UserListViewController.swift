//
//  UserListViewController.swift
//  Tracking
//
//  Created by Earshad on 29/06/24.
//

import UIKit
import RealmSwift

class UserListViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var addAccountBtn: UIButton!
    
    var viewModel:UserViewModel?
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUsers()
    }
    
    func getUsers() {
        users = viewModel?.getAllUsers() ?? []
        userTableView.reloadData()
    }
    
    @IBAction func closeClick(_ sender: Any) {
        self.hideView()
    }
    
    @IBAction func signoutClick(_ sender: Any) {
        self.hideView()
        if let user = viewModel?.getCurrentUser() {
            viewModel?.logout(email: user.email)
            viewModel?.userChanged.send(.signOut)
        }
    }
    
    @IBAction func addAccountClick(_ sender: Any) {
        self.hideView()
        viewModel?.userChanged.send(.signOut)
    }
    
    func setupView() {
        self.userTableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.signoutBtn.styleButton()
        self.addAccountBtn.styleButton()
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.view.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    
    func hideView() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.view.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }

    }
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as?
            UserListTableViewCell {
            let user = users[indexPath.row]
            if user.isLoggedIn == true {
                cell.userNameLabel.textColor = .green
            } else {
                cell.userNameLabel.textColor = .black
            }
            cell.userNameLabel.text = user.username
            cell.emailLabel.text = user.email
            cell.containerView.boxShadow()
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchUser(users[indexPath.row])
    }
    
    func switchUser(_ user: User) {
        viewModel?.changeUser(user: user)
        hideView()
    }
    
}
