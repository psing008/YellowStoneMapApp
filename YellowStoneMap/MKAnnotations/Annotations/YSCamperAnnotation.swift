//
//  YSCamperAnnotation.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/26/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

class YSCamperAnnotation:NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var imageName: String {
        return "camperIcon"
    }
    var camperModel: YSCamperProtocol
    
    init(camper: YSCamperProtocol) {
       camperModel = camper
       coordinate = CLLocationCoordinate2D(latitude: camperModel.latitude, longitude: camperModel.longitude)
    }
    
    
    var title: String? {
        return camperModel.name
    }
    
    var subtitle: String? {
        return camperModel.descriptionText
    }
    
    var phoneNumber: String? {
        return camperModel.phoneNumber
    }
    
}
