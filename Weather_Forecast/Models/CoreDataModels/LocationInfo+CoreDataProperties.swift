//
//  LocationInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationInfo> {
        return NSFetchRequest<LocationInfo>(entityName: "LocationInfo")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
