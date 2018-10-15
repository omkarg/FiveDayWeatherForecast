//
//  ForecastCollectionViewCell.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var seaLevelLbl: UILabel!
    @IBOutlet weak var groundLevelLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var weatherInfoLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windDegreeLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    @IBOutlet weak var snowLbl: UILabel!
    @IBOutlet weak var cloudinessLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.brown.cgColor
        self.layer.borderWidth = 2.0
    }
    
    func setData(detail:ForecastDetails)
    {
        timeLbl.text = detail.timeText!
        
        let tempCelsius = String(format: "%.2f", detail.main!.temp - 273.15)
        let tempMinCelsius = String(format: "%.2f", detail.main!.temp_min - 273.15)
        let tempMaxCelsius = String(format: "%.2f", detail.main!.temp_max - 273.15)
        
        tempLbl.text = "\(tempCelsius)ºC (\(tempMinCelsius)ºC/\(tempMaxCelsius)ºC)"
        seaLevelLbl.text = "\(String(describing: detail.main!.seaLevel)) hPa"
        groundLevelLbl.text = "\(String(describing: detail.main!.groundLevel)) hPa"
        humidityLbl.text = "\(String(describing: detail.main!.humidity))%"
        pressureLbl.text = "\(String(describing:detail.main!.pressure)) hPa"
        weatherInfoLbl.text = (detail.weather!.allObjects[0] as! WeatherInfo).descp
        windSpeedLbl.text = "\(String(describing: detail.wind!.speed)) m/sec"
        windDegreeLbl.text = "\(String(describing: detail.wind!.degree))º"
        rainLbl.text = detail.rain == nil ? "0 mm":detail.rain!+" mm"
        snowLbl.text = detail.snow == nil ? "0 mm":detail.snow!+" mm"
        cloudinessLbl.text = "\(detail.cloudiness)"
        
    }
    
}
