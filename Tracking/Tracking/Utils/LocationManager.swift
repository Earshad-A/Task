//
//  LocationManager.swift
//  Tracking
//
//  Created by Earshad on 07/07/24.
//

import Foundation
import RealmSwift
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private let realm = try! Realm()
    
    private var timer: Timer?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        startUpdatingLocation()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 900, target: self, selector: #selector(saveLocation), userInfo: nil, repeats: true)
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("got new location")

    }
    
//    func startBackgroundTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 900, repeats: true) { [weak self] _ in
//            self?.locationManager.requestLocation()
//        }
//        timer?.tolerance = 60 // Allow system flexibility in scheduling
//    }
//    
//    func stopBackgroundTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
    
    @objc func saveLocation() {
        let currentUser = realm.objects(User.self).filter("isLoggedIn == true").first
        if let currentLocation = locationManager.location {
            do {
                try realm.write {
                    let location = Location()
                    location.latitude = currentLocation.coordinate.latitude
                    location.longitude = currentLocation.coordinate.longitude
                    location.userEmail = currentUser?.email ?? ""
                    realm.add(location)
                }
            } catch {
                print("Error")
            }
        }
    }
}
