

import SwiftUI

struct ContentView: View {
  let places: [Place]
  @State private var selectedPlace: Place
    @StateObject private var locationManager = LocationManager()

  init(places: [Place]) {
    self.places = places
    _selectedPlace = .init(initialValue: places.first!)
  }
  
  var body: some View {
    NavigationView {
      PlacesView(places: places, selectedPlace: $selectedPlace, locationManager: locationManager)
        .background(RoadView())
      .navigationBarHidden(true)
      
      Text("\(Image(systemName: "arrow.left")) Choose an Interesting Place!")
        .font(.largeTitle)
    }
    .onAppear {
        locationManager.fetchAddress(for: selectedPlace)
        locationManager.setupMonitoring(for: places)
    }
    .alert(isPresented: $locationManager.inRegion){
        Alert(title: Text("You are near \(locationManager.regionName). Check it out!"))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let places = MapDirectory().places
    ContentView(places: places)
    ContentView(places: places)
      .previewDevice("iPhone 11 Pro Max")
  }
}

private struct PlacesView: View {
  let places: [Place]
  @Binding var selectedPlace: Place
    @ObservedObject var locationManager: LocationManager
  
  var body: some View {
    VStack {
      NavigationLink(destination: DetailView(location: selectedPlace)) {
        LocationPhoto(photoName: selectedPlace.image)
      }
      .padding(.horizontal)
      
      TitleView(locationName: selectedPlace.name)
        .padding([.top, .horizontal])
      Spacer()
      VStack(spacing: 16) {
          Text(locationManager.currentAddress)
          .foregroundColor(.white)
          .font(.title3)
          .bold()
        LocationOptionsView(place: selectedPlace, places: places)
      }
      Spacer()
      OtherPlacesScrollView(selectedPlace: $selectedPlace, locationManager: locationManager, places: places)
        .padding(.vertical)
    }
  }
}

private struct LocationOptionsView: View {
  let place: Place
  let places: [Place]
  
  var body: some View {
    VStack(spacing: 10) {
        NavigationLink(destination: MapView(location: place, places: places)) {
          Label(
            title: { Text("Find on Map")
              .foregroundColor(.white)
              .fontWeight(.bold) },
            icon: {
              Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.black)
            }
          )
    }
      Button {
        print("Directions goes here")
      } label: {
        Label(
          title: { Text("Get Directions")
            .foregroundColor(.white)
            .fontWeight(.bold) },
          icon: {
            Image(systemName: "map.fill")
              .foregroundColor(.black)
          }
        )
      }
    }
  }
}

private struct OtherPlacesScrollView: View {
    @Binding var selectedPlace: Place {
        didSet {
            locationManager.fetchAddress(for: selectedPlace)
        }
    }
  @ObservedObject var locationManager: LocationManager
  let places: [Place]
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(places.indices, id: \.self) { index in
          let place = places[index]
          Image(place.image)
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .aspectRatio(1, contentMode: .fill)
            .onTapGesture {
              selectedPlace = place
            }
        }
      }
      .padding(.leading)
    }
    
  }
}
