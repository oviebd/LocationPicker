//
//  LocationSearchViewModel.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 20/12/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()

    private let searchCompleter = MKLocalSearchCompleter()

    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }

    func getCoordinateAsync(localSearch: MKLocalSearchCompletion) async -> LocationData? {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)

        do {
            let result = try await search.start()
            guard let firstCoordinate = result.mapItems.first?.placemark.coordinate else {
                return nil
            }

            return await LocationUtility.convertLatLongToLocationData(latitude: firstCoordinate.latitude, longitude: firstCoordinate.longitude)
           

        } catch {
            return nil
        }
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
}
