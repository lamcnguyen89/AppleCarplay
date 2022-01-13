

import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @StateObject private var locationQuery: LocationQuery
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $locationQuery.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(locationQuery.searchResults, id: \.self, rowContent: Text.init)
            }
            .navigationTitle("Search")
        }
    }
    
    init(region: MKCoordinateRegion) {
        _locationQuery = StateObject(wrappedValue: LocationQuery(region: region))
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinate = CLLocationCoordinate2D(latitude: 33.6525, longitude: -85.8296)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        MapSearchView(region: region)
    }
}
