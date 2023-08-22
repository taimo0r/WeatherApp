//
//  ImageManager.swift
//  WeatherApp
//
//  Created by Daniyal Siddiqui on 2023-08-04.
//

import UIKit

class ImageManager {
    static func getWeatherImagesBasedOn(codeForWeather: Int) -> UIImage? {
        let config =  UIImage.SymbolConfiguration.preferringMulticolor()

        switch codeForWeather {
        case 1009, 1135:
            return UIImage(systemName: "smoke.fill", withConfiguration: config)
        case 1063, 1087, 1150, 1153, 1180, 1183, 1186, 1189, 1192, 1195, 1198, 1201, 1240, 1243, 1246, 1273, 1276:
            return UIImage(systemName: "cloud.bolt.rain.fill", withConfiguration: config)
        case 1066, 1072, 1147, 1168, 1171, 1210, 1213, 1216, 1219, 1222, 1225, 1237, 1255, 1258, 1261, 1264, 1279, 1282:
            return UIImage(systemName: "snowflake")
        case 1000:
            return UIImage(systemName: "sun.max.fill", withConfiguration: config)
        case 1003:
            return UIImage(systemName: "cloud.sun.fill", withConfiguration: config)
        case 1006, 1030:
            return UIImage(systemName: "cloud.fill")
        default:
            return UIImage(systemName: "cloud.sun.fill", withConfiguration: config)
        }
    }
}
