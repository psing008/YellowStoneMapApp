//
//  CampsiteDataModel.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

enum CampsiteStatus: Int, Codable {
    case open = 1
    case closed = 0
}

protocol Identifiable {
    var identifier: Int { get }
}

protocol HasNameProtocol: Codable {
     var name: String {get}
}
protocol HasLocationProtocol: Codable {
    var latitude: CLLocationDegrees { get }
    var longitude: CLLocationDegrees { get }
}

protocol HasDescriptionProtocol: Codable {
     var descriptionText: String? { get }
}

protocol CampSiteModelProtocol: HasNameProtocol, HasLocationProtocol, HasDescriptionProtocol, Identifiable {
    var status: CampsiteStatus { get set}
}

struct YSCampSiteDataModel: Codable, CampSiteModelProtocol {
    
    var identifier: Int
    var status: CampsiteStatus
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var descriptionText: String?
}



