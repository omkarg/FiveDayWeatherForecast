//
//  ForecastDetails+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension ForecastDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastDetails> {
        return NSFetchRequest<ForecastDetails>(entityName: "ForecastDetails")
    }

    @NSManaged public var cloudiness: Int32
    @NSManaged public var date: String?
    @NSManaged public var sys: String?
    @NSManaged public var unixDate: Int64
    @NSManaged public var rain: String?
    @NSManaged public var snow: String?
    @NSManaged public var timeText: String?
    @NSManaged public var main: TemperatureInfo?
    @NSManaged public var weather: NSSet?
    @NSManaged public var wind: WindInfo?

}

// MARK: Generated accessors for weather
extension ForecastDetails {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherInfo)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherInfo)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
