//
//  CamperAnnotationView.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/26/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

class CamperAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let camperAnnotation = newValue as? YSCamperAnnotation else {
                return
            }
            image = UIImage(named: camperAnnotation.imageName)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = camperAnnotation.subtitle
            detailLabel.text?.append("\nPhone: \(camperAnnotation.phoneNumber ?? "")")
            
            detailCalloutAccessoryView = detailLabel
            canShowCallout = true
            
        }
    }
}

