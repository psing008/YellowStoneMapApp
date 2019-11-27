//
//  YSBoundingBox.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/24/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

protocol BoundingBox {
    var latmin: CLLocationDegrees { get }
    var latmax: CLLocationDegrees  { get }
    var lngmin: CLLocationDegrees  { get }
    var lngmax: CLLocationDegrees  { get }
    
    func center(span: MKCoordinateSpan) -> CLLocationCoordinate2D
}

extension BoundingBox {
    func center(span: MKCoordinateSpan)-> CLLocationCoordinate2D {
        var center = CLLocationCoordinate2D()
        center.latitude = fmax(latmin,latmax) - (span.latitudeDelta / 2.0)
        center.longitude = fmax(lngmin,lngmax) - (span.longitudeDelta / 2.0)
        return center
    }
}
struct YSBoundingBox: BoundingBox {
    
    var latmin = 44.12354048271325
    var latmax = 45.11911641599412
    var lngmin = -109.8305463801207
    var lngmax = -111.15594815937659
}


