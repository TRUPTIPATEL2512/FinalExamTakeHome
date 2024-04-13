//
//  NewsTableViewCell.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit

class NewsDataTableViewCell: UITableViewCell {
    
    //Here are the IBOutlet for News datatable viewcell
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    //Here I'm Sets up the cell using data from a Newsdata object.
    func setupCell(data: NewsData) {
        lblAuthor.text = "Author: \(data.author ?? "")"
        lblSource.text = "Source: \(data.source ?? "")"
        lblTitle.text = "Title: \(data.title ?? "")"
        lblFrom.text = "From: \(data.from ?? "")"
        lblContent.text = "Content: \(data.content ?? "")"
        lblCity.text = "City Name: \(data.cityName ?? "")"
    }

}
