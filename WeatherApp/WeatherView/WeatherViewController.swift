//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 31/07/2023.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var labelWeatherCondition: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var buttonCities: UIButton!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonLocation: UIButton!
    
    var weatherTracker: WeatherModel?
    var searchedCity: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.searchBar.delegate = self
        self.buttonCities.layer.cornerRadius = self.buttonCities.frame.height / 2
        self.labelTemperature.text = ""
        self.labelCityName.text = ""
        self.labelWeatherCondition.text = ""
        self.searchBar.layer.cornerRadius = 10
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    fileprivate func makeInitialWeatherRequest() {
        LocationManager.shared.getLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                print("latitude: " ,location.coordinate.latitude)
                print("longitude: " ,location.coordinate.longitude)
                
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                
                WeatherViewModel.fetchWeatherDetailsWith(latitude: latitude, longitude: longitude) { weatherModel, status in
                    switch status {
                    case true:
                        self.weatherTracker = weatherModel
                        self.computeWeatherDetailsBeforeRendering(weatherModel: weatherModel, ifCurrentLocation: true)
                    case false:
                        break
                    }
                }
            }
        }
    }
    
    fileprivate func computeWeatherDetailsBeforeRendering(weatherModel: WeatherModel?, ifCurrentLocation: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.weatherTracker = weatherModel
            let locationName = ifCurrentLocation == true ? "Current Location" : "\(weatherModel?.location.name ?? "")"
            strongSelf.labelCityName.text = locationName
            strongSelf.labelWeatherCondition.text = "\(weatherModel?.current.condition?.text ?? "")"
            strongSelf.labelTemperature.text = "\(weatherModel?.current.tempC ?? 0.0)"
            strongSelf.weatherImageView.image = ImageManager.getWeatherImagesBasedOn(codeForWeather: weatherModel?.current.condition?.code ?? 0)
            
            LocalDataManager.weatherCollection.append(WeatherLocalModel(cityName: locationName, weatherCondition: weatherModel?.current.condition?.text ?? "", temperature: String(weatherModel?.current.tempC ?? 0.0), imageCode: weatherModel?.current.condition?.code ?? 0))
            
        }
    }
    
    fileprivate func makeRequest() {
        self.view.endEditing(true)
        WeatherViewModel.fetchWeatherBasedOn(cityName: self.searchedCity) { WeatherModel, status in
            switch status {
            case true:
                self.computeWeatherDetailsBeforeRendering(weatherModel: WeatherModel, ifCurrentLocation: false)
            case false:
                print("bad request")
            }
        }
    }
    
    @IBAction func didSelectSegmentControl(_ sender: UISegmentedControl) {
        guard let weather = weatherTracker else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.labelTemperature.text = "\(weather.current.tempC ?? 0.0)"
        case 1:
            self.labelTemperature.text = "\(weather.current.tempF ?? 0.0)"
        default:
            break
        }
    }
    
    
    @IBAction func didTapLocation(_ sender: Any) {
        self.makeInitialWeatherRequest()
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        self.makeRequest()
    }
    
    @IBAction func didTapCities(_ sender: Any) {}
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.searchedCity = searchText
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            self.searchedCity = searchText
            self.makeRequest()
        }
    }
}
