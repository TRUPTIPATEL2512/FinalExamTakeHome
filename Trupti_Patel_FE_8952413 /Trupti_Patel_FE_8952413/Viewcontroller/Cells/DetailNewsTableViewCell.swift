//
//  DetailNewsTableViewCell.swift
//  Trupti_Patel_FE_8952413
//
//  Created by user238294 on 4/10/24.
//

import UIKit

class DetailNewsTableViewCell: UITableViewCell {
    
    //Here are the IBOutlet for Detail News Table viewcell
    @IBOutlet weak var lblAthr: UILabel!
    @IBOutlet weak var lblsrc: UILabel!
    @IBOutlet weak var lbltitl: UILabel!
    @IBOutlet weak var lblcntnt: UILabel!
    
    //Here I'm declaring Function to set up the cell with data from an article
    func setupUI(article: Article) {
        lblAthr.text = "Author: \(article.author ?? "Unknown")"
        lblsrc.text = "Source: \(article.source?.name ?? "")"   
        lbltitl.text = "Title: \(article.title ?? "")"
        lblcntnt.text = "Content: \(article.description ?? "")"
    }
}
