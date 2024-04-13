//
//  Main.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit
import MapKit

class Main: UIViewController, MKMapViewDelegate, UITabBarDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    
    //Here are the IBOutlets that are present on the main screen
    @IBOutlet weak var mapUI: MKMapView!
    @IBOutlet weak var temperaturelevel: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var weatherimg: UIImageView!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Final", style: .plain, target: nil, action: nil)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        mapUI.delegate = self
        mapUI.showsUserLocation = true
    }
    
    //Here I'm declaring a function prepare to fetch data from the destination source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        if sender.tag == 2 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 1
            }
        } else if sender.tag == 3 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 2
            }
        }
    }
    
    //This function is for Updates the UI with the weather data
    func updateUI(with data: WeatherModel) {
        temperaturelevel.text = "\(Int(data.main.temp))°C"
        WindSpeed.text = "Wind: \(data.wind.speed)Km/h"
        Humidity.text = "Humidity: \(data.main.humidity)"
        weatherimg.image = UIImage(systemName: mapWeatherConditionToSymbol(data.weather.first?.id ?? 0))
    }
    
    //This fuction is for Hides the navigation bar on the main screen
    func navigationController(_ navigation: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let hide = (viewController is Main)
        navigation.setNavigationBarHidden(hide, animated: animated)
    }
    
    //This fuction is for updating the location
    func locationManager(_ lManager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            lManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapUI.setRegion(region, animated: true)
        fetchWeatherData(for: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
    }
    
    //Here I'm fetching weather data through the apikey
    private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let apiKey = "6554c931b0421b176988b8a39861a37a"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
