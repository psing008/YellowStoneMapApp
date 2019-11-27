//
//  YSMapViewController
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/23/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import UIKit
import MapKit

class YSMapViewController: UIViewController, YSMapViewControllerProtocol {
    
    
    var mapView: MKMapView = MKMapView()
    var campsiteCalloutViewController: CampsiteCalloutViewController?
    
    lazy var viewModel: YSMapVCViewModelProtocol =  {
        let vm = YSMapVCViewModel()
        
        vm.updateAnnotation = { (annotation: MKAnnotation, state: UpdateState) -> Void in
            if state == .add {
             self.mapView.addAnnotation(annotation)
            } else {
             self.mapView.removeAnnotation(annotation)
            }
        }
        vm.updateCallout = { (camp: CampSiteModelProtocol) -> Void in
            self.campsiteCalloutViewController?.updateView(model: camp)
        }
        
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        centerMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCampsiteAndCamperAnnotations()
    }
}

extension YSMapViewController {
    
    private func loadCampsiteAndCamperAnnotations() {
        guard
            let campsiteAnnotation = viewModel.campSiteAnnotations,
            let campersAnnotation = viewModel.campersAnnotations
            else  { return }
        mapView.addAnnotations(campsiteAnnotation)
        mapView.addAnnotations(campersAnnotation)
    }
    
    private func setUpMapView() {
        mapView.register(CampsiteAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.delegate = self
       
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            let safeAreaExtendedToBottomLayoutGuide = UILayoutGuide()
            view.addLayoutGuide(safeAreaExtendedToBottomLayoutGuide)
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: view.topAnchor),
                mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                mapView.widthAnchor.constraint(equalTo: guide.widthAnchor)
            ])
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: standardSpacing)
            ])
        }
    }
    
    private func centerMapView() {
      
        var region = MKCoordinateRegion()
        let (center, span) = viewModel.metaData
        
        region.center = center
        region.span = span
        mapView.setRegion( region, animated: false )
    }
}

extension YSMapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view: MKAnnotationView?
        
        if let annotation = annotation as? YSCampSiteAnnotation {
            let identifier = "campsite"
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? CampsiteAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                view?.tag = annotation.identifier
            } else {
                view = CampsiteAnnotationView()
                view!.annotation = annotation
                view?.tag = annotation.identifier
            }
        } else if let annotation = annotation as?  YSCamperAnnotation {
            let identifier = "camper"
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? CamperAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = CamperAnnotationView()
                view!.annotation = annotation
            }
            // allow dragging
            
            view?.canShowCallout = false
            view?.isDraggable = true
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard
            let campsiteAnnotationView = view as? CampsiteAnnotationView,
            let annotation = campsiteAnnotationView.annotation as? YSCampSiteAnnotation
            else { return }
        
        let camp = annotation.campModel
        
        showCampSiteCallout(camp: camp, annotationView: campsiteAnnotationView)
    }
    
    private func showCampSiteCallout(camp: CampSiteModelProtocol, annotationView: CampsiteAnnotationView ) {
        campsiteCalloutViewController = CampsiteCalloutViewController()
        campsiteCalloutViewController?.delegate = self
        campsiteCalloutViewController?.loadViewIfNeeded()
        campsiteCalloutViewController?.updateView(model: camp)
        campsiteCalloutViewController?.modalPresentationStyle = .popover
        let presentationController = campsiteCalloutViewController?.presentationController as! UIPopoverPresentationController
        presentationController.delegate = self
        presentationController.sourceView = annotationView
        presentationController.sourceRect = annotationView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        guard let calloutVC = campsiteCalloutViewController else { return }
        self.present(calloutVC, animated: true)
    }

}

extension YSMapViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        guard let selectedAnnotation = mapView.selectedAnnotations.first else {return}
        mapView.deselectAnnotation(selectedAnnotation, animated: false)
        campsiteCalloutViewController?.popoverPresentationController?.delegate = nil
        campsiteCalloutViewController = nil
    }

}

extension YSMapViewController : CampsiteCalloutViewControllerDelegate {
    
    func closeCampsiteButtonClicked(identifier: Int) {
         viewModel.updateCampsiteAnnotation(annotations: mapView.selectedAnnotations, identifier: identifier)

    }
}
