//
//  LocationPickerFormView.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 17/11/23.
//

import SwiftUI
import CoreLocation

struct LocationPickerFormView: View {
    
    var buttonHint: String
    @State private var showSheet = false
    @Binding var pickedLocationData: LocationData

    @State var currentLocationData : CLLocationCoordinate2D?
    let locationManager = LocationManager.shared
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct LocationPickerFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationPickerFormView()
//    }
//}
