

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    var locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    lazy var geocoder = CLGeocoder()
    var regionName = ""
    
    @Published var locationString = ""
    @Published var currentAddress = ""
    @Published var inRegion = false
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func fetchAddress(for place: Place) {
        currentAddress = ""
        geocoder.reverseGeocodeLocation(place.location) { [weak self] placemarks, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            guard let placemark = placemarks?.first else { return }
            if let streetNumber = placemark.subThoroughfare,
               let street = placemark.thoroughfare,
               let city = placemark.locality,
               let state = placemark.administrativeArea {
                DispatchQueue.main.async {
                    self?.currentAddress = "\(streetNumber) \(street) \(city), \(state)"
                }
            } else if let city = placemark.locality, let state = placemark.administrativeArea {
                DispatchQueue.main.async {
                    self?.currentAddress = "\(city), \(state)"
                }
            } else {
                DispatchQueue.main.async {
                    self?.currentAddress = "Address Unknown"
                }
            }
        }
    }
    
    func setupMonitoring(for places: [Place]) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            for place in places {
                let region = CLCircularRegion(center: place.location.coordinate, radius: 500, identifier: place.name)
                region.notifyOnEntry = true
                locationManager.startMonitoring(for: region)
            }
        }
    }

    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        inRegion = true
        regionName = region.identifier
        locationManager.stopMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.first else { return }
        if previousLocation != nil {
            previousLocation = latest
        } else {
            let distanceInMeters = previousLocation?.distance(from: latest) ?? 0
            previousLocation = latest
            locationString = "You are \(Int(distanceInMeters)) meters from your start point"
        }
        print(latest)
        //locationString = "location: \(latest.description)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        switch clError {
        case CLError.denied:
            print("Access Denied")
        default:
            print("Catch all errors")
            
        }
    }
}
