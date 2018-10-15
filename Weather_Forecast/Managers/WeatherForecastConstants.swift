//
//  WeatherForecastConstants.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import Foundation
import UIKit

let city = "mumbai"
let countryCode = "IN"
let apiKey = "6022296ba2cc4d976ac7111978e224ec"
let domain = "http://api.openweathermap.org"

let kRefreshTime = "refreshTime"
let kRefreshInterval = 300.0 // 5 min interval (5X60=300)

//API Endpoints
let fiveDayWeatherForecastURL = "\(domain)/data/2.5/forecast?q=\(city),\(countryCode)&APPID=\(apiKey)"



extension UIView{
    func showBlurLoader(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func removeBluerLoader(){
        self.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}
