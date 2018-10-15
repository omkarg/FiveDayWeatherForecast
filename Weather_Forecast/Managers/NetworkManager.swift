//
//  NetworkManager.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import Foundation

class NetworkManager
{
    static let shared = NetworkManager()
    let sharedSession = URLSession.shared
    
    private init(){}
    
    func get5DayWeatherForecast(completion: @escaping ([String: Any]?,NSError?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: fiveDayWeatherForecastURL) {
                let request = URLRequest(url: url)
                let dataTask = self.sharedSession.dataTask(with: request) { (data, response, error) -> Void in
                    if error == nil
                    {
                        if let httpResponse = response as? HTTPURLResponse
                        {
                            if (httpResponse.statusCode == 200)
                            {
                                do {
                                    let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                                    completion(jsonDictionary,nil)
                                } catch {
                                    NSLog("ERROR \(error.localizedDescription)")
                                    let err =  NSError(domain:"JSON Parsing error", code:900, userInfo:nil)
                                    completion(nil,err)
                                }
                            }
                            else
                            {
                                let err = NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: nil)
                                completion(nil,err)
                            }
                        }
                        else{
                            let err = NSError(domain: "Failed to create HTTP Response", code: 901, userInfo: nil)
                            completion(nil,err)
                        }
                    }
                    else
                    {
                        completion(nil,error! as NSError)
                    }
                }
                dataTask.resume()
            }
        }
    }
    
}
