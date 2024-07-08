//
//  LocationListViewController.swift
//  Tracking
//
//  Created by Earshad on 07/07/24.
//

import UIKit

class LocationListViewController: UIViewController {
    @IBOutlet weak var locationTableView: UITableView!
    var viewModel:UserViewModel?
    var locationList:[Location] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.locationTableView.register(UINib(nibName: "LocationListTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationListTableViewCell")
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        getData()
    }
    
    func getData() {
        locationList = viewModel?.getAllLocationsForCurrentUser() ?? []
        locationTableView.reloadData()
        
    }

}


extension LocationListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListTableViewCell", for: indexPath) as?
            LocationListTableViewCell {
            cell.selectionStyle = .none
            cell.title.text = "Location \(indexPath.row)"
            cell.subtitle.text = "(\(locationList[indexPath.row].latitude), \(locationList[indexPath.row].longitude))"
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.locations = locationList
        vc.currentLocationIndex = indexPath.row
//        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
