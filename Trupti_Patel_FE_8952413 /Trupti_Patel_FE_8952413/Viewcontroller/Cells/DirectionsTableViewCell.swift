//
//  DirectionsTableViewCell.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//
import UIKit

class DirectionsTableViewCell: UITableViewCell {

    //Here are the IBOutlet for Directions table viewcell
    @IBOutlet weak var lblCitynme: UILabel!
    @IBOutlet weak var lblTravel: UILabel!
    @IBOutlet weak var lblModeofTravel: UILabel!
    @IBOutlet weak var lblEndPoint: UILabel!
    @IBOutlet weak var lblStartPoint: UILabel!
    
    //Here I'm Sets up the cell using data from a Direction tableview.
    func setup(data: DirectionsData) {
        lblCitynme.text = data.cityName ?? ""
        lblTravel.text = data.distance ?? ""
        lblModeofTravel.text = data.method
        lblEndPoint.text = data.endPoint ?? ""
        lblStartPoint.text = data.startPoint ?? ""
    }
}
