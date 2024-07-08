//
//  UserViewModel.swift
//  Tracking
//
//  Created by Earshad on 06/07/24.
//
import Foundation
import RealmSwift
import Combine

enum UserAction {
    case signOut
    case changeUser
}

class UserViewModel {
    private var realm: Realm
    var userChanged = PassthroughSubject<UserAction, Never>()

    init() {
        
        realm = try! Realm()
        
    }

    func signUp(email: String, password: String, username: String) -> Bool {
        if realm.object(ofType: User.self, forPrimaryKey: email) != nil {
            return false
        }
        let user = User()
        user.email = email
        user.password = password
        user.username = username
        
        do {
            try realm.write {
                let allUsers = realm.objects(User.self)
                allUsers.setValue(false, forKey: "isLoggedIn")
                realm.add(user)
                user.isLoggedIn = true
            }
//            userChanged.send()
            return true 
        } catch {
            return false
        }
    }

    func login(email: String, password: String) -> Bool {
        if let user = realm.object(ofType: User.self, forPrimaryKey: email) {
            if user.password == password {
                try! realm.write {
                    user.isLoggedIn = true
                }
                return true
            }
        }
        return false
    }

    func logout(email: String) {
        if let user = realm.object(ofType: User.self, forPrimaryKey: email) {
            try! realm.write {
                user.isLoggedIn = false
            }
        }
    }

    func getCurrentUser() -> User? {
        return realm.objects(User.self).filter("isLoggedIn == true").first
    }

    func getAllUsers() -> [User] {
        let users = realm.objects(User.self)
        return Array(users)
    }
    
    func switchUser(to email: String, password: String) -> Bool {
        if let currentUser = getCurrentUser() {
            logout(email: currentUser.email)
        }
        return login(email: email, password: password)
    }
    
        
    func getAllLocationsForCurrentUser() -> [Location]? {
        if let currentUser = getCurrentUser() {
            let locations = realm.objects(Location.self).filter("userEmail == %@", currentUser.email)
            return Array(locations)
        }
        return nil
    }
    
    func changeUser(user: User) {
        do {
            try realm.write {
                let allUsers = realm.objects(User.self)
                allUsers.setValue(false, forKey: "isLoggedIn")
                user.isLoggedIn = true
            }
            userChanged.send(.changeUser)
        }
        catch {
            print("err")
        }
    }
}
