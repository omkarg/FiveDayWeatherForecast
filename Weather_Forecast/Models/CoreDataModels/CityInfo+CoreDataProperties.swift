//
//  CityInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension CityInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityInfo> {
        return NSFetchRequest<CityInfo>(entityName: "CityInfo")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var latlong: LocationInfo?

}
