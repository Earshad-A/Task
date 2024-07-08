//
//  MapViewController.swift
//  Tracking
//
//  Created by Earshad on 08/07/24.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapContainer: UIView!
    var mapView: GMSMapView!
    var locations:[Location] = []
    var currentLocationIndex = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
               mapView = GMSMapView.init()
               mapView.translatesAutoresizingMaskIntoConstraints = false
               mapView.delegate = self
               mapContainer.addSubview(mapView)

        let camera = GMSCameraPosition.camera(withLatitude: locations[currentLocationIndex].latitude, longitude: locations[currentLocationIndex].longitude, zoom: 10.0)
               mapView.camera = camera

               // Add constraints to the mapView
               NSLayoutConstraint.activate([
                   mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   mapView.topAnchor.constraint(equalTo: view.topAnchor),
                   mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])

               
        
        for i in currentLocationIndex..<locations.count {
            placeMarker(location: locations[i], index: i)
        }
        moveToLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playBackClick(_ sender: Any) {
        currentLocationIndex += 1
        moveToLocation()
    }

    func moveToLocation() {
        guard currentLocationIndex < locations.count else {return}
        let cam = GMSCameraPosition.camera(withLatitude: locations[currentLocationIndex].latitude, longitude: locations[currentLocationIndex].longitude, zoom: 16.0)
        mapView.camera = cam
        mapView.animate(to: cam)
    }
    
    func placeMarker(location: Location, index: Int) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = "Location \(index)"
        marker.snippet = "(\(location.latitude),\(location.longitude))"
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = Bundle.main.loadNibNamed("CallOutView", owner: self)?.first as! CallOutView
        view.titleLabel.text = marker.title
        view.subTitleLabel.text = marker.snippet
        return view
        }

}
