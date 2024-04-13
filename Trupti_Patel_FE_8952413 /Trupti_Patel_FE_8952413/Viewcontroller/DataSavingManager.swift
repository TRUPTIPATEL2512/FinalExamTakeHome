//
//  DataSavingManager.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit
import CoreData

class DataSavingManager {
    static let shared = DataSavingManager()
    
    private init() {}
    
    //Here I'm declaring CoreData for Direction part history
    func saveDirection(cityName: String, distance: String, from: String, method: String, startPoint: String, endPoint: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        //Here I'm Declaring all the variable present in  direction data which is the part of Coredata
        let direction = DirectionsData(context: context)
        direction.cityName = cityName
        direction.distance = distance
        direction.from = from
        direction.method = method
        direction.dataType = SaveData.directions.rawValue
        direction.startPoint = startPoint
        direction.endPoint = endPoint
        do {
            try context.save()
        } catch {
            print("Failed to save direction: \(error.localizedDescription)")
        }
    }
    
    //Here I'm Saving news information into Core Data
    func saveNews(author: String, cityName: String, content: String, from: String, source: String, title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        //Here I'm Declaring all the variable present in  news data which is the part of Coredata
        let news = NewsData(context: context)
        news.author = author
        news.cityName = cityName
        news.content = content
        news.from = from
        news.source = source
        news.title = title
        news.dataType = SaveData.news.rawValue

        do {
            try context.save()
        } catch {
            print("Failed to save news: \(error.localizedDescription)")
        }
    }

    //Here I'm saving Weather information into Core Data
    func saveWeather(cityName: String, date: String, humidity: String, temp: String, time: String, wind: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        //Here I'm Declaring all the variable present in  weather data which is the part of Coredata
        let weather = WeatherCoreData(context: context)
        weather.cityName = cityName
        weather.date = date
        weather.humidity = humidity
        weather.temp = temp
        weather.time = time
        weather.wind = wind
        weather.dataType = SaveData.weather.rawValue
        
        do {
            try context.save()
        } catch {
            print("Failed to save weather: \(error.localizedDescription)")
        }
    }
    
    // Here i'm Checking if it's the first launch of the app to setup default data.
    func firstCheckMethod() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "firstLaunch") {
            defaults.set(true, forKey: "firstLaunch")
            defaults.synchronize()
            let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"]
            for city in cities {
                saveNews(author: "Anonymous", cityName: city, content: "Sample news content", from: "Local News", source: "Sample Source", title: "Sample News Title")
            }
        }
    }
}
