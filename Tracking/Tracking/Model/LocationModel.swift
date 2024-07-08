//
//  LocationModel.swift
//  Tracking
//
//  Created by Earshad on 07/07/24.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var userEmail: String = ""
    @objc dynamic var timestamp = Date()
}
