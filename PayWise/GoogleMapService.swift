//
//  GoogleMapService.swift
//  PayWise
//
//  Created by Yan Zhan on 6/3/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
//import GooglePlaces
//import GoogleMaps
import CoreLocation

class GoogleMapService : CLLocationManager, CLLocationManagerDelegate {
    override init() {
        super.init()
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.delegate = self
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
        print("getting location")
    }
    
    func updateLocation() {
        self.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = (self.location!.coordinate)
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}
