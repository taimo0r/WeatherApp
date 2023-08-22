//
//  WeatherListTableViewCell.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 01/08/2023.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCondition: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var labelCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
