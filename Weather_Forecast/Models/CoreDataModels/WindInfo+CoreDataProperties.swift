//
//  WindInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension WindInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindInfo> {
        return NSFetchRequest<WindInfo>(entityName: "WindInfo")
    }

    @NSManaged public var degree: Double
    @NSManaged public var speed: Double

}
