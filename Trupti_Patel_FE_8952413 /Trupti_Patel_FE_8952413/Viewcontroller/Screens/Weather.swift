//
//  Weather.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit

class Weather: UIViewController {
    
    //Here are the IBOutlets
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lbltemperature: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblwindSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Weather"
        fetchWeatherData(for: "Waterloo")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rightBarBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBttnTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc func rightBttnTapped() {
        showCityInputAlert(on: self, title: "Enter City Name", message: "Please enter the name of the city:") { [weak self] cityName in
            self?.fetchWeatherData(for: cityName)
        }
    }
    
    //Here I'm Fetching data through apikey
    private func fetchWeatherData(for city: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=6554c931b0421b176988b8a39861a37a&units=metric") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    //Here I'm declaring function 
    func Weather(data: WeatherModel) {
        DataSavingManager.shared.saveWeather(cityName: data.name,
                                date: Date.getCurrentDate(),
                                humidity: "\(data.main.humidity)%",
                                temp: "\(Int(data.main.temp))°C",
                                time: Date().currentTime(),
                                wind: "\(data.wind.speed) km/h")
    }
    
    private func updateUI(with weatherData: WeatherModel) {
        lblCityName.text = weatherData.name
        lbldescription.text = weatherData.weather.first?.description ?? "N/A"
        lbltemperature.text = "\(Int(weatherData.main.temp))°C"
        lblHumidity.text = "Humidity: \(weatherData.main.humidity)%"
        lblwindSpeed.text = "Wind: \(weatherData.wind.speed) km/h"
        
        Weather(data: weatherData)
    }
}
