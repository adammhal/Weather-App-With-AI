//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    
    var manager = CLLocationManager()
    
    func checkLocationAuthorization() async{
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location restricted")
            case .denied:
                print("Location denied")
            case .authorizedAlways:
                print("Location authorizedAlways")
            case .authorizedWhenInUse:
                lastKnownLocation = manager.location?.coordinate
            case .authorized:
                print("Location authorized")
            @unknown default:
                print("Location disabled")
        }
    }
    
    private func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) async {
        await checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
}
