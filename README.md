# FiveDayWeatherForecast

A native iOS app to display 5 days weather forecasts. Data via [OpenWeatherMap](http://openweathermap.org/forecast5). Everytime the app is launched the data is fetched from OpenWeatherMap and stored locally, on the next launch of the app if the time difference between the two launches is more than 5 min it will fetch new data else it will show the previously locally stored data. The location used in the API is Mumbai,India. You can change this info in WeatherForecastConstants.swift.

## Install

Requirements:
  
* [XCode 9.4](https://developer.apple.com/xcode/)  

## Target
1. iOS 10 and above

## Project
1. Open the Weather_Forecast.xcodeproj in XCode.
2. Incase you need to change the location for which data is fetched you can change that in WeatherForecastConstants.swift
3. You can also change the refresh interval(in seconds) which is mentioned in WeatherForecastConstants.swift.

## Run/Build/Test

Use XCode to run, build and test the code:

* Choose `Run` to run the app on a Simulator or device;

## Implement in future

* Unit Test cases
* Downloading weather icons
* Delete old data
* Device date/time is used for calculating 5 min difference in two app launches depending on which the weather forecast data is refreshed  , in proper situation we can get the date/time from server. Because in current scenario if we change the date in settings it will refresh irrespective of the 5 min logic that is currently applied
* Data refresh logic every 5 min or as per required time interval.
