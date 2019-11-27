//
//  CampsiteAnnotationView.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/26/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import MapKit

class CampsiteAnnotationView: MKAnnotationView {
    
    var customView: CampsiteAnnotationContentView?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var annotation: MKAnnotation? {
        
        willSet {
            customView?.removeFromSuperview()
            customView = nil
            
            guard let campsiteAnnotation = newValue as? YSCampSiteAnnotation else {
                return
            }
           
            customView = CampsiteAnnotationContentView(imageName: campsiteAnnotation.imageName, title: campsiteAnnotation.title)
            customView?.translatesAutoresizingMaskIntoConstraints = false
            addSubview(customView!)
            customView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            customView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 24, height: 24)
            
        }
    }
    
//    func useDefaultCallout(){
//
//        let detailLabel = UILabel()
//        detailLabel.numberOfLines = 0
//        detailLabel.font = detailLabel.font.withSize(12)
//        detailLabel.text = "Description : \(campsiteAnnotation.subtitle ?? "")"
//        detailLabel.text?.append("\n\nStatus: \(campsiteAnnotation.status)")
//
//        detailCalloutAccessoryView = detailLabel
//        canShowCallout = true
//
//        let closeButton = UIButton(frame: CGRect(origin: CGPoint.zero,
//                                                size: CGSize(width: 30, height: 30)))
//        closeButton.setBackgroundImage(UIImage(named: "closeIcon"), for: UIControl.State())
//        rightCalloutAccessoryView = closeButton
//    }
    

}

