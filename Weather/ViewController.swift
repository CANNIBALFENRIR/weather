//
//  ViewController.swift
//  Weather
//
//  Created by Гость on 20.06.2022.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var weatherData = weatherData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocationManager()
        // Do any additional setup after loading the view.
    }
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    func UpdateWeatherinfo(latitude: Double, longtitude: Double) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&appid=60aaa4e2978a80f695973b70aa22fe1b")!
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                print(self.weatherData)
            }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

extension ViewController: CLLocationManagerDelegate {
    func locationManager(  manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
