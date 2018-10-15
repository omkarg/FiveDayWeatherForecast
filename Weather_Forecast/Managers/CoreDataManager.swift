//
//  CoreDataManager.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import Foundation

import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init(){}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Weather_Forecast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext (completion: (Bool) -> ()) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(true)
            } catch {
                completion(false)
            }
        }
        else
        {
            completion(true)
        }
    }
    
    
    
    func saveJSONToCoreData(jsonDictionary:[String:AnyObject],completion: (Bool) -> ()) {
        let forecastInfoData = NSEntityDescription.insertNewObject(forEntityName: "ForecastInfo", into: persistentContainer.viewContext)
        forecastInfoData.setValue(jsonDictionary["cod"], forKey: "cod")
        forecastInfoData.setValue(jsonDictionary["message"], forKey: "message")
        forecastInfoData.setValue(jsonDictionary["cnt"], forKey: "count")
        
        //store city info
        let cityInfoData = NSEntityDescription.insertNewObject(forEntityName: "CityInfo", into: persistentContainer.viewContext)
        cityInfoData.setValue(jsonDictionary["city"]?["id"] ?? 0, forKey: "id")
        cityInfoData.setValue(jsonDictionary["city"]?["name"] ?? "Not Found", forKey: "name")
        cityInfoData.setValue(jsonDictionary["city"]?["country"] ?? "Not Found", forKey: "country")
        
        let locationInfoData = NSEntityDescription.insertNewObject(forEntityName: "LocationInfo", into: persistentContainer.viewContext)
        let locationDictionary = jsonDictionary["city"]?["coord"] as! [String:AnyObject]
        locationInfoData.setValue(locationDictionary["lat"], forKey: "latitude")
        locationInfoData.setValue(locationDictionary["lon"], forKey: "longitude")
        cityInfoData.setValue(locationInfoData, forKey: "latlong")
        forecastInfoData.setValue(cityInfoData, forKey: "city")
        
        //Main data
        let mainDataArray = jsonDictionary["list"] as! NSArray
        var listArray = NSSet()
        for individualData in mainDataArray {
            
            let individualDataDictionary = individualData as! [String:AnyObject]
            let foreCastDetailsData = NSEntityDescription.insertNewObject(forEntityName: "ForecastDetails", into: persistentContainer.viewContext)
            foreCastDetailsData.setValue(individualDataDictionary["clouds"]?["all"] ?? 0, forKey: "cloudiness")
            
            let dateTimeString = individualDataDictionary["dt_txt"] as! String
            let dateIndex = dateTimeString.index(dateTimeString.startIndex, offsetBy: 10)
            let dateString = dateTimeString.prefix(upTo: dateIndex)
            foreCastDetailsData.setValue(dateString, forKey: "date")
            
            let timeIndex = dateTimeString.index(dateTimeString.endIndex, offsetBy: -8)
            let timeString = dateTimeString.suffix(from: timeIndex)
            foreCastDetailsData.setValue(timeString, forKey: "timeText")
            
            foreCastDetailsData.setValue(individualDataDictionary["dt"], forKey: "unixDate")
            foreCastDetailsData.setValue(individualDataDictionary["sys"]?["pod"] ?? "Not Found", forKey: "sys")
            //wind data
            let windInfoData = NSEntityDescription.insertNewObject(forEntityName: "WindInfo", into: persistentContainer.viewContext)
            windInfoData.setValue(individualDataDictionary["wind"]?["speed"] ?? 0, forKey: "speed")
            windInfoData.setValue(individualDataDictionary["wind"]?["degree"] ?? 0, forKey: "degree")
            foreCastDetailsData.setValue(windInfoData, forKey: "wind")
            //main -> temperature data
            let mainData = NSEntityDescription.insertNewObject(forEntityName: "TemperatureInfo", into: persistentContainer.viewContext)
            mainData.setValue(individualDataDictionary["main"]?["temp"] ?? 0, forKey: "temp")
            mainData.setValue(individualDataDictionary["main"]?["temp_min"] ?? 0, forKey: "temp_min")
            mainData.setValue(individualDataDictionary["main"]?["temp_max"] ?? 0, forKey: "temp_max")
            mainData.setValue(individualDataDictionary["main"]?["pressure"] ?? 0, forKey: "pressure")
            mainData.setValue(individualDataDictionary["main"]?["sea_level"] ?? 0, forKey: "seaLevel")
            mainData.setValue(individualDataDictionary["main"]?["grnd_level"] ?? 0, forKey: "groundLevel")
            mainData.setValue(individualDataDictionary["main"]?["humidity"] ?? 0, forKey: "humidity")
            mainData.setValue(individualDataDictionary["main"]?["temp_kf"] ?? 0, forKey: "tempKf")
            foreCastDetailsData.setValue(mainData, forKey: "main")
            //weather data
            let weatherArray = individualDataDictionary["weather"] as! NSArray
            var weatherList = NSSet()
            for individualWeather in weatherArray {
                let weatherInfoData = NSEntityDescription.insertNewObject(forEntityName: "WeatherInfo", into: persistentContainer.viewContext)
                let individualWeatherDictionary = individualWeather as! [String:AnyObject]
                weatherInfoData.setValue(individualWeatherDictionary["id"], forKey: "id")
                weatherInfoData.setValue(individualWeatherDictionary["main"], forKey: "main")
                weatherInfoData.setValue(individualWeatherDictionary["icon"], forKey: "icon")
                weatherInfoData.setValue(individualWeatherDictionary["description"], forKey: "descp")
                weatherList = weatherList.adding(weatherInfoData) as NSSet
            }
            foreCastDetailsData.setValue(weatherList, forKey: "weather")
            listArray = listArray.adding(foreCastDetailsData) as NSSet
        }
        forecastInfoData.setValue(listArray, forKey: "list")
        saveContext { (result) in
            completion(result)
        }
    }
    
    func getForecastDetails(completion:([String: [ForecastDetails]]?,[NSDictionary]?,NSError?) -> Void){
        var results = [String:[ForecastDetails]]()
        //get unique dates
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "ForecastDetails")
        let sort = NSSortDescriptor(key: #keyPath(ForecastDetails.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.propertiesToFetch = ["date"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = .dictionaryResultType
        do{
            let uniqueDateArray = try persistentContainer.viewContext.fetch(fetchRequest)
            for uniqueDate in uniqueDateArray {
                let request:NSFetchRequest<ForecastDetails> = ForecastDetails.fetchRequest()
                let sort = NSSortDescriptor(key: #keyPath(ForecastDetails.unixDate), ascending: true)
                request.sortDescriptors = [sort]
                request.predicate = NSPredicate(format: "date == %@",uniqueDate.value(forKey: "date") as! CVarArg)
                do {
                    results["\(String(describing: uniqueDate.value(forKey: "date")!))"] =  try persistentContainer.viewContext.fetch(request) as [ForecastDetails]
                } catch _ as NSError { completion(nil,nil,NSError(domain: "exception", code: 905, userInfo: nil)) }
            }
            completion(results,uniqueDateArray,nil)
        }
        catch _ as NSError { completion(nil,nil,NSError(domain: "exception", code: 905, userInfo: nil)) }
    }
    
    
    func deleteAllCoreData() {
        deleteEntityData("CityInfo")
        deleteEntityData("ForecastDetails")
        deleteEntityData("ForecastInfo")
        deleteEntityData("LocationInfo")
        deleteEntityData("TemperatureInfo")
        deleteEntityData("WeatherInfo")
        deleteEntityData("WindInfo")
    }
    
    func deleteEntityData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
