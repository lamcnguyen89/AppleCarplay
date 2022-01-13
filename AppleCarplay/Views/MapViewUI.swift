

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
            
            switch annotation {
            case let cluster as MKClusterAnnotation:
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
                annotationView.markerTintColor = .brown
                for clusterAnnotation in cluster.memberAnnotations {
                    if let place = clusterAnnotation as? Place {
                        if place.sponsored {
                            cluster.title = place.name
                            break
                        }
                    }
                }
                annotationView.titleVisibility = .visible
                return annotationView
            case let placeAnnotation as Place:
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "InterestingPlace") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Interesting Place")
                annotationView.canShowCallout = true
                annotationView.glyphText = "👀"
                annotationView.clusteringIdentifier = "cluster"
                annotationView.markerTintColor = UIColor(displayP3Red: 0.082, green: 0.518, blue: 0.263, alpha: 1.0)
                annotationView.titleVisibility = .visible
                annotationView.detailCalloutAccessoryView = UIImage(named: placeAnnotation.image).map(UIImageView.init)
                
                return annotationView
                
            default: return nil
            }
            

        }
    }
    
}
