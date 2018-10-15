//
//  TemperatureInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension TemperatureInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TemperatureInfo> {
        return NSFetchRequest<TemperatureInfo>(entityName: "TemperatureInfo")
    }

    @NSManaged public var groundLevel: Double
    @NSManaged public var humidity: Float
    @NSManaged public var pressure: Double
    @NSManaged public var seaLevel: Double
    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var tempKf: Double

}
