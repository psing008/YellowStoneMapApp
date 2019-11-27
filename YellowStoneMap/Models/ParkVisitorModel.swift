//
//  ParkVisitorModel.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

enum Location {
    case Latitude
    case Longitude
}

protocol PersonProtocol: HasNameProtocol, HasDescriptionProtocol {
    var phoneNumber: String? { get }
}

protocol YSCamperProtocol: PersonProtocol, HasLocationProtocol {}

struct YSCamper: YSCamperProtocol {
    var phoneNumber: String?
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var descriptionText: String?
    
    init(phone number: String?, lat: CLLocationDegrees, long: CLLocationDegrees,name person: String, description: String?) {
        phoneNumber = number
        latitude = lat
        longitude = long
        name = person
        descriptionText = description
    }
}

struct YSRandomCamperGenerator {
    
    var randomNames: [String]  = ["Sam","John","Bob","Elliot","Matt","Paul","Stacy","Ashley","Jake","Melissa","Peter"]
    var digitList:[String] = ["0","1","2","3","4","5","6","7","8","9"]
    
    func randomPhoneNumber()-> String {
        var phoneNumber = ""
        for _ in 0...9 {
            phoneNumber.append(digitList.randomElement() ?? "")
        }
        return phoneNumber
    }
    
    func randomLocation(type: Location, boundingBox: BoundingBox)-> CLLocationDegrees {
        switch type {
        case .Latitude:
            return Double.random(in: boundingBox.latmin...boundingBox.latmax)
        case .Longitude:
            return Double.random(in: boundingBox.lngmax...boundingBox.lngmin)
            
        }
    }
    
    func randomName()-> String {
        return randomNames.randomElement() ?? ""
    }
    
    func randomDescription() -> String {
        return "Age : \(Int.random(in: 18...80)) \nHeight: \(Int.random(in: 4..<7))'\(Int.random(in: 0...12))"
    }
    
    var randomCamper: YSCamper {
        let boundingBox = YSBoundingBox()
        let latitude = randomLocation(type: .Latitude, boundingBox: boundingBox)
        let longitude = randomLocation(type: .Longitude, boundingBox: boundingBox)
        let phoneNumber = randomPhoneNumber()
        let description = randomDescription()
        let name = randomName()
        
        return YSCamper(phone: phoneNumber, lat: latitude, long: longitude, name: name, description: description)
    }
    
}

