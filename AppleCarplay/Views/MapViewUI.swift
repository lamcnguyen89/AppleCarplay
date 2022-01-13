

import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {
    
    let location: Place
    let places: [Place]
    let mapViewType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(location.region, animated: false)
        mapView.mapType = mapViewType
        mapView.isRotateEnabled = false
        mapView.addAnnotations(places)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapViewType
    }
    
    func makeCoordinator() -> MapCoordinator {
        .init()
    }
    
    final class MapCoordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            guard let placeAnnotation = annotation as? Place else {
                return nil
            }
            
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "InterestingPlace") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Interesting Place")
            
            annotationView.canShowCallout = true
            annotationView.glyphText = "👀"
            annotationView.markerTintColor = UIColor(displayP3Red: 0.082, green: 0.518, blue: 0.263, alpha: 1.0)
            annotationView.titleVisibility = .visible
            annotationView.detailCalloutAccessoryView = UIImage(named: placeAnnotation.image).map(UIImageView.init)
            
            return annotationView
        }
    }
    
}
