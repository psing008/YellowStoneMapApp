//
//  YSMapVCViewModel.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

enum UpdateState {
    case add
    case remove
    case update
}

protocol YSViewModelProtocol {
    func dataChanged()
}

protocol YSMapVCViewModelProtocol {
    func loadCampSiteData(fileName: String)-> [CampSiteModelProtocol]?
    var campSites: [CampSiteModelProtocol]? { get set }
    var campSiteAnnotations: [YSCampSiteAnnotation]? { get }
    var campersAnnotations: [YSCamperAnnotation]? { get }
    var metaData:(CLLocationCoordinate2D, MKCoordinateSpan) { get }
    var campers: [YSCamperProtocol]? { get }
    func updateCampsiteAnnotation(annotations: [MKAnnotation], identifier: Int)
}

class YSMapVCViewModel: YSMapVCViewModelProtocol  {

    var updateAnnotation: ((MKAnnotation,UpdateState) -> (Void))?
    var updateCallout: ((CampSiteModelProtocol) -> (Void))?
    
    lazy var campSites: [CampSiteModelProtocol]? = loadCampSiteData(fileName: "campsites")
    
    var campers: [YSCamperProtocol]? {
        let numberOfCampers = 20
        let randomGenerator = YSRandomCamperGenerator()
        var campers = [YSCamper]()
        for _ in 0..<numberOfCampers {
            let camper = randomGenerator.randomCamper
            campers.append(camper)
        }
        return campers
    }
    
    var campSiteAnnotations: [YSCampSiteAnnotation]? {
        return campSites?.map({ YSCampSiteAnnotation(camp: $0)})
    }
    
    lazy var campersAnnotations: [YSCamperAnnotation]? = {
        return campers?.map({ YSCamperAnnotation(camper: $0)})
    }()
    
    var metaData: (CLLocationCoordinate2D, MKCoordinateSpan) {
        
        var span = MKCoordinateSpan()
        let boundingBox = YSBoundingBox()
        span.latitudeDelta = fabs(boundingBox.latmax - boundingBox.latmin)
        span.longitudeDelta = fabs(boundingBox.lngmax - boundingBox.lngmin)
        let center = boundingBox.center(span: span)
        
        return (center,span)
    }
    
    lazy var boundingBox: BoundingBox = {
        return YSBoundingBox()
    }()
    
    func loadCampSiteData(fileName: String) -> [CampSiteModelProtocol]? {
        
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("error reading JSON file for campsite")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let result = try JSONDecoder().decode(Array<YSCampSiteDataModel>.self, from: data)
            return result
           
        } catch {
            print(error)
        }
        
        return nil
    }
}

extension YSMapVCViewModel {
    
    func updateCampsiteAnnotation(annotations: [MKAnnotation], identifier: Int) {
        guard
            let campsiteToEditIndex = campSites?.firstIndex(where: { (model) -> Bool in
                model.identifier == identifier
            }),
            var camp = campSites?[campsiteToEditIndex]
            else  { return }
        
        if camp.status == .open {
            camp.status = .closed
        } else {
            camp.status = .open
        }
        
        //update data model
        campSites?[campsiteToEditIndex] = camp
        
        let currentAnnotation = annotations.filter { (selectedAnnotation) -> Bool in
            if let anno = selectedAnnotation as? YSCampSiteAnnotation {
                return anno.identifier == identifier
            }
            return false
        }.first as? YSCampSiteAnnotation
        
        guard let selectedAnnotation  = currentAnnotation else {
            return
        }
        
         self.updateAnnotation?(selectedAnnotation,.remove)
         selectedAnnotation.campModel = camp
         self.updateAnnotation?(selectedAnnotation,.add)
         self.updateCallout?(camp)
    }
}
