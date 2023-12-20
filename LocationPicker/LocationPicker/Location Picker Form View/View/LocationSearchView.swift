//
//  LocationSearchView.swift
//  LocationPicker
//
//  Created by Habibur Rahman on 20/12/23.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var pickedLocationData: LocationData
    var locationSelectionAction: (LocationData) -> Void

    @StateObject private var viewModel = LocationSearchViewModel()
    @State private var showingAlert : Bool = false
    
    var body: some View {
        VStack {
            SearchView(searchText: $viewModel.queryFragment)
                .padding(.top, 50)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) {
                        result in
                        LocationSearchResultCell(title: result.title, subTitle: result.subtitle)
                            .onTapGesture {
                                Task {
                                    var fetchedLocationData = await viewModel.getCoordinateAsync(localSearch: result)
                                    if let locationData = fetchedLocationData {
                                        pickedLocationData = locationData
                                        locationSelectionAction(pickedLocationData)
                                        self.presentationMode.wrappedValue.dismiss()
                                    } else {
                                        showingAlert = true
                                        print("No Data found ....")
                                    }
                                }
                            }
                    }
                }
            }.padding(.top, 40)

        }.padding(.horizontal, 20)
            .alert("Please sealect another one ", isPresented: $showingAlert) {
                      Button("OK", role: .cancel) { }
                  }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(pickedLocationData: .constant(LocationData()), locationSelectionAction: {
            _ in
        })
    }
}
