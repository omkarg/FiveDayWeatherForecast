//
//  ForecastTableViewCell.swift
//  Weather_Forecast
//
//  Created by Omkar Guhilot on 14/10/18.
//  Copyright © 2018 omkar. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    var foreCastDetailsForSpecificDate = [ForecastDetails]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(details:[ForecastDetails])
    {
        foreCastDetailsForSpecificDate = details
        forecastCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return foreCastDetailsForSpecificDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let forecastCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCollectionViewCellIdentifier", for: indexPath) as! ForecastCollectionViewCell
        return forecastCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if cell is ForecastCollectionViewCell
        {
            (cell as? ForecastCollectionViewCell)?.setData(detail: foreCastDetailsForSpecificDate[indexPath.row])
        }
    }
}
