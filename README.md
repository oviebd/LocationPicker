# LocationPicker

This lightweight and customizable iOS Location Picker provides a user-friendly interface for selecting locations within your app. This features a sophisticated search functionality that enables users to input their desired location, subsequently providing tailored suggestions. Furthermore, the system can retrieve the user's current location, enhancing overall user experience and convenience.

## Key Features

- **Search Functionality:** An intuitive search feature enables users to easily find and select their desired locations.

- **Tailored Suggestions:** The picker provides customized suggestions based on user input, streamlining the location selection process.

- **Current Location Retrieval:** The system can retrieve the user's current location, enhancing overall user experience and convenience.


## How to Use
1. **Integration:**
   - Add **Location Picker Form View** folder from this repository into your project.
   
2. **Code:**
   - Create a state variable of type **LocationData** within your view. This variable will serve as the data holder for the selected location.
   - Bind the **LocationData** object with the **LocationPickerFormView**. This ensures that the selected location updates dynamically as the user interacts with the location picker.
     
```swift
  struct LocationData {
      var city : String = ""
      var country : String = ""
      var coordinate : CLLocationCoordinate2D?
  }

  @State var locationData : LocationData = LocationData()
    
    var body: some View {
        VStack {
            LocationPickerFormView(buttonHint: "Pick Location", pickedLocationData: $locationData)
        }
        .padding()
    }
```
By following these steps, you establish a seamless connection between your view and the LocationPickerFormView, allowing for real-time updates to the LocationData object based on user location selections.
