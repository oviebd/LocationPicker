//
//  LocationManager.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 17/11/23.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, ObservableObject{

    static let shared = LocationManager()
    private let clLocationManager = CLLocationManager()
   
    @Published var location: CLLocationCoordinate2D?
    @Published var isLocationFound : Bool = false
    
    override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.requestWhenInUseAuthorization()
    }
    
    func requestForLocation(){
        isLocationFound = false
        clLocationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard !locations.isEmpty else {return}
        location = locations.first?.coordinate

        clLocationManager.stopUpdatingLocation()
        isLocationFound = true
    }
    
}
