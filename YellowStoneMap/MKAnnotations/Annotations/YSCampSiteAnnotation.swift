//
//  YSCampSiteAnnotation.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

class YSCampSiteAnnotation:NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var imageName: String {
        return "campsiteIcon"
    }
    var campModel:CampSiteModelProtocol
    
    init(camp: CampSiteModelProtocol) {
        campModel = camp
        coordinate = CLLocationCoordinate2D(latitude: campModel.latitude, longitude: campModel.longitude)
    }
    
    var title: String? {
        return campModel.name
    }
    
    var subtitle: String? {
        return campModel.descriptionText
    }
    var status: CampsiteStatus {
        return campModel.status
    }
    
    var identifier: Int {
        return campModel.identifier
    }
    
}
