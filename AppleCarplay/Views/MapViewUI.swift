

import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {
    
    let location: Place
    let mapViewType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(location.region, animated: false)
        mapView.mapType = mapViewType
        mapView.isRotateEnabled = false
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapViewType
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
    }
    
}
