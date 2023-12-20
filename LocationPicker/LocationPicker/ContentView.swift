//
//  ContentView.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 17/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var locationData : LocationData = LocationData()
    
    var body: some View {
        VStack {
            LocationPickerFormView(buttonHint: "Pick Location", pickedLocationData: $locationData)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
