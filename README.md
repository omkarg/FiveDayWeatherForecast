# FiveDayWeatherForecast

A native iOS app to display 5 days weather forecasts. Data via [OpenWeatherMap](http://openweathermap.org/forecast5). Everytime the app is launched the data is fetched from OpenWeatherMap and stored locally, on the next launch of the app if the time difference between the two launches is more than 5 min it will fetch new data else it will show the previously locally stored data. The location used in the API is Mumbai,India. You can change this info in WeatherForecastConstants.swift.

## Install

Requirements:
  
* [XCode 9.4](https://developer.apple.com/xcode/)  

## Project
1. Open the Weather_Forecast.xcodeproj in XCode.


## Run/Build/Test

Use XCode to run, build and test the code:

* Choose `Run` to run the app on a Simulator or device;

## Implement in future

* Unit Test cases
* Downloading weather icons
* Delete old data
* Device time is stored for weather refresh logic , in proper situation we can get the date/time from server. In current scenario if we change the date in settings it will refresh irrespective of the 5 min logic that is currently applied
* Data refresh logic
