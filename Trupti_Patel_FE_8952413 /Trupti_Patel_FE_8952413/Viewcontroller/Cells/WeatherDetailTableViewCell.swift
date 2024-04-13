//
//  WeatherDetailTableViewCell.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblWindspeed: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    //Here I'm Sets up the cell using data from a WeatherCoreData object.
    func setup(data: WeatherCoreData) {
        lblWindspeed.text = "Wind: \(data.wind ?? "")"
        lblHumidity.text = "Humidity: \(data.humidity ?? "")"
        lblTemp.text = "Temp: \(data.temp ?? "")"
        lblTime.text = "Time: \(data.time ?? "")"
        lblDate.text = data.date ?? ""
        lblFrom.text = data.from ?? ""
        lblCity.text = data.cityName ?? ""
    }
}
