//
//  LocationPickerFormView.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 17/11/23.
//

import CoreLocation
import SwiftUI

struct LocationPickerFormView: View {
    var buttonHint: String
    @State private var showSheet = false
    @Binding var pickedLocationData: LocationData

    @ObservedObject var locationManager = LocationManager.shared
    @State var locationText: String = ""

    var body: some View {
        HStack {
            Text(locationText.isEmpty ? buttonHint : locationText)
                .font(.subheadline)
                .foregroundColor(pickedLocationData.city.isEmpty ? Color.gray.opacity(0.8) : Color.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 0)
                .onAppear{
                    setLocationText()
                }

            Spacer()

            Button{
                locationManager.requestForLocation()
                pickedLocationData = locationManager.locationData
                setLocationText()
            }label: {
                Image(systemName: "location.fill")
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                    .foregroundColor(.gray.opacity(0.5))
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .center)
        .frame(height: 48)
        .background(Color.white)
        .cornerRadius(44)
        .overlay(Capsule()
            .inset(by: 0.5)
            .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
        )
        .onTapGesture {
            showSheet = true
        }
        .onChange(of: LocationManager.shared.isLocationFound) { _ in
            pickedLocationData = locationManager.locationData
            setLocationText()
        }
        .sheet(isPresented: $showSheet) {
            LocationSearchView(pickedLocationData: $pickedLocationData, locationSelectionAction: {
                newLocationData in
                self.pickedLocationData = newLocationData
                setLocationText()
            })
        }
    }
    
    
    func setLocationText() {
        
        Task{
            let resultString = await LocationUtility.getLocationTextFromPickedLocationData(locationData: pickedLocationData)
            locationText = resultString
        }
    }

}

struct LocationPickerFormView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerFormView(buttonHint: "Pick Location", pickedLocationData: .constant(LocationData()))
    }
}
