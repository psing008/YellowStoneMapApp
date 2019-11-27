//
//  YSMapViewControllerProtocol.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

protocol YSMapViewControllerProtocol {
    var mapView: MKMapView { get }
    var viewModel: YSMapVCViewModelProtocol { get }
    var campsiteCalloutViewController: CampsiteCalloutViewController? { get }
}
