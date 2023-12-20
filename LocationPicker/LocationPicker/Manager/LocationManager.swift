//
//  LocationManager.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 17/11/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    private let clLocationManager = CLLocationManager()

    @Published var isLocationFound: Bool = false
    @Published var locationData: LocationData = LocationData()

    override init() {
        super.init()
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.requestWhenInUseAuthorization()
    }

    func requestForLocation() {
        isLocationFound = false
        clLocationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first?.coordinate else { return }

        clLocationManager.stopUpdatingLocation()

        Task {
            let fetchedLocation = await LocationUtility.convertLatLongToLocationData(latitude: firstLocation.latitude, longitude: firstLocation.longitude)

            locationData.coordinate = firstLocation
            locationData.city = fetchedLocation?.city ?? ""
            locationData.country = fetchedLocation?.country ?? ""

            isLocationFound = true
        }
    }
}
