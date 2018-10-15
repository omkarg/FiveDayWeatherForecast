//
//  ForecastInfo+CoreDataProperties.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 15/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//
//

import Foundation
import CoreData


extension ForecastInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastInfo> {
        return NSFetchRequest<ForecastInfo>(entityName: "ForecastInfo")
    }

    @NSManaged public var cod: String?
    @NSManaged public var count: Int32
    @NSManaged public var message: Int32
    @NSManaged public var city: CityInfo?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension ForecastInfo {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: ForecastDetails)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: ForecastDetails)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}
