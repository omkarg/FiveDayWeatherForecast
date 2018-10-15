//
//  WeatherInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfo> {
        return NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
    }

    @NSManaged public var descp: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int32
    @NSManaged public var main: String?

}
