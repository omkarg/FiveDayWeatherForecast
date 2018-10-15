//
//  MainViewController.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var foreCastDetailsDictionary = [String:[ForecastDetails]]()
    var dateOrderArrayDictionary = [NSDictionary]()
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var latlongLbl: UILabel!
    @IBOutlet weak var noData_lbl: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var forecast_tablView: UITableView!
    var refreshTimer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityLbl.text = city
        self.countryLbl.text = countryCode
        refreshTimer = Timer.scheduledTimer(timeInterval: kRefreshInterval, target: self, selector: #selector(self.refreshData), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.showBlurLoader()
        if shouldGetNewData() {
            getForecastData()
        }
        else {
            setData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshTimer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func refreshData() {
        getForecastData()
    }
    
    func shouldGetNewData() -> Bool {
        let refreshInterval = UserDefaults.standard.double(forKey:kRefreshTime)
        if  refreshInterval>0 {
            let currentTimeInterval = Date().timeIntervalSince1970
            return currentTimeInterval-refreshInterval > kRefreshInterval ? true:false
        }
        return true
    }
    
    func getForecastData() {
        NetworkManager.shared.get5DayWeatherForecast { (jsonDictionary, error) in
            if error == nil{
                if jsonDictionary != nil
                {
                    CoreDataManager.shared.saveJSONToCoreData(jsonDictionary: jsonDictionary! as [String : AnyObject], completion: { (result) in
                        if result == true
                        {
                            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: kRefreshTime)
                            self.setData()
                        }
                    })}
            }
            else {
                self.handleError(error: error!)
            }
        }
    }
    
    func setData(){
        CoreDataManager.shared.getForecastDetails { (result, dateOrderArray, error) in
            if error == nil {
                foreCastDetailsDictionary = result!;
                dateOrderArrayDictionary = dateOrderArray!
                refreshTableView()
            }
            else {
                handleError(error: error!)
            }
        }
    }
    
    func handleError(error:NSError){
        DispatchQueue.main.async {
            self.showHideRespectiveView()
            self.view.removeBluerLoader()
            let alert = UIAlertController(title: "Alert", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
            if let e = error as? URLError, e.code == .notConnectedToInternet {
                //show no internet alert
                alert.message = "Kindly check your internet connection and please try again"
            }
            else {
                //show other errors
                alert.message = (error.localizedDescription.count>0) ? error.localizedDescription : "Unknown error. Please try again"
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showHideRespectiveView() {
        if self.foreCastDetailsDictionary.count < 1{
            self.noData_lbl.isHidden = false
            self.retryButton.isHidden = false
            self.forecast_tablView.isHidden = true
        }
        else{
            self.noData_lbl.isHidden = true
            self.retryButton.isHidden = true
            self.forecast_tablView.isHidden = false
        }
    }
    
    @IBAction func retry_action(_ sender: Any){
        self.view.showBlurLoader()
        getForecastData()
    }
    
    // MARK: - Table View Handling
    func refreshTableView(){
        DispatchQueue.main.async {
            self.showHideRespectiveView()
            self.view.removeBluerLoader()
            self.forecastTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dateOrderArrayDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let forecastCell = tableView.dequeueReusableCell(withIdentifier: "forecastTableViewCellIdentifier", for: indexPath) as! ForecastTableViewCell
        return forecastCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if cell is ForecastTableViewCell{
            let dateString = dateOrderArrayDictionary[indexPath.row].value(forKey: "date") as? String
            (cell as! ForecastTableViewCell).dateLabel.text = dateString
            (cell as! ForecastTableViewCell).setData(details: foreCastDetailsDictionary[dateString!]!)//pass only specific days data
        }
    }
}
