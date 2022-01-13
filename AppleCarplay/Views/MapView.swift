

import SwiftUI
import MapKit

struct MapView: View {

    let location: Place
    let places: [Place]

    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .standard
    @Environment(\.presentationMode) private var presentationMode

    init(location: Place, places: [Place]) {
        self.location = location
        _region = State(initialValue: location.region)
        self.places = places
    }

    var body: some View {
        ZStack {
            MapViewUI(location: location, places: places,  mapViewType: mapType)
            
//            Map(coordinateRegion: $region, annotationItems: places) {
//                    item in
//                //MapMarker(coordinate: item.location.coordinate, tint: Color.red)
//                //MapPin(coordinate: item.location.coordinate, tint: Color.red)
//                MapAnnotation(coordinate: item.location.coordinate) {
//                    VStack {
//                        Circle()
//                            .fill(Color.red)
//                        Text(item.name)
//                            .bold()
//                    }
//                }
//            }
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                Picker("", selection: $mapType) {
                    Text("Standard").tag(MKMapType.standard)
                    Text("Hybrid").tag(MKMapType.hybrid)
                    Text("Satellite").tag(MKMapType.satellite)
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .offset(y: -28)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: MapDirectory().places[0], places: MapDirectory().places)
    }
}



