//
//  LocationViewController.swift
//  DiveMapExample
//
//  Created by Kyrill van Seventer on 01/11/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

import Foundation
import CoreLocation

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            self.locationmanager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DiveMapService.sharedInstance.getDiveMapData(lat: location.coordinate.latitude, lng: location.coordinate.longitude, dist: 25)
            self.locationmanager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

}
