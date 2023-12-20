//
//  LocationUtility.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 20/12/23.
//

import CoreLocation
import Foundation

class LocationUtility {
    // Location
    static func getLocationTextFromLatitudeLongitude(lat: Double, longitude: Double, completation: @escaping ((String) -> Void)) async -> String {
        
        let locationData = await convertLatLongToLocationData(latitude: lat, longitude: longitude)
        if let data = locationData {
            return getLocationString(pickedLocationData: data)
        }
        return ""
    }
    
    static func getLocationTextFromPickedLocationData(locationData: LocationData) async -> String {
        if let coordinate = locationData.coordinate {
            
            let locationData = await convertLatLongToLocationData(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            if let data = locationData {
                return getLocationString(pickedLocationData: data)
            }
           
        }
        return ""
    }

    static func makeCLLocationCoordinate2DFromLatLng(lat: Double?, longitude: Double?) -> CLLocationCoordinate2D? {
        if let lat = lat, let lon = longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return nil
    }

    private static func getLocationString(pickedLocationData: LocationData) -> String {
        let result = pickedLocationData.country
        if result.isEmpty == false && pickedLocationData.city.isEmpty == false {
            return "\(pickedLocationData.city),\(result)"
        }
        if pickedLocationData.city.isEmpty == false {
            return pickedLocationData.city
        }

        if let coordinate = pickedLocationData.coordinate, result.isEmpty {
            return "lat : \(coordinate.latitude), lon: \(coordinate.longitude)"
        }
        return result
    }

    public static func convertLatLongToLocationData(latitude: Double, longitude: Double) async -> LocationData? {
        var locationData: LocationData = LocationData()

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        locationData.coordinate = makeCLLocationCoordinate2DFromLatLng(lat: latitude, longitude: longitude)

        do {
            let placemarks = try await geoCoder.reverseGeocodeLocation(location)
            if placemarks.count > 0 {
                let placeMark = placemarks[0]

                // City
                if let city = placeMark.locality {
                    print("city \(city)")
                    locationData.city = city
                }

                // State
                if let state = placeMark.administrativeArea {
                    if locationData.city.isEmpty {
                        locationData.city = state
                    }

                    print("STate \(state)")
                }

                // Country
                if let country = placeMark.country {
                    print("Country \(country)")
                    locationData.country = country
                }
                return locationData
            } else {
                return nil
            }
        } catch {
            return nil
        }
        //  return false
    }

//    public static func convertLatLongToLocationData(latitude: Double, longitude: Double, completation: @escaping ((LocationData) -> Void)) {
//        var pickedLocationData: LocationData = LocationData()
//
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        pickedLocationData.coordinate = makeCLLocationCoordinate2DFromLatLng(lat: latitude, longitude: longitude)
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, _ in
//
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//
//            // Location name
////            if let locationName = placeMark.location {
////                print(locationName)
////            }
//            // Street address
////            if let street = placeMark.thoroughfare {
////                print(street)
////            }
////            // City
//            if let city = placeMark.locality {
//                print("city \(city)")
//                pickedLocationData.city = city
//            }
//            // State
//            if let state = placeMark.administrativeArea {
//                if pickedLocationData.city.isEmpty {
//                    pickedLocationData.city = state
//                }
//
//                print("STate \(state)")
//            }
//            // Zip code
////            if let zipCode = placeMark.postalCode 3
////                print(zipCode)
////            }
////            // Country
//            if let country = placeMark.country {
//                print("Country \(country)")
//
//                pickedLocationData.country = country
//            }
//
//            completation(pickedLocationData)
//        })
//    }
}
