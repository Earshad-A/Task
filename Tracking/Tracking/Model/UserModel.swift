//
//  UserModel.swift
//  Tracking
//
//  Created by Earshad on 06/07/24.
//
import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var isLoggedIn: Bool = false
    
    override static func primaryKey() -> String? {
        return "email"
    }
}
