//
//  ViewControllerExtensions.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/27/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func setPreferredContentSizeFromAutolayout() {
        let contentSize = self.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        
        self.preferredContentSize = contentSize
        self.popoverPresentationController?
            .presentedViewController
            .preferredContentSize = contentSize
    }
}
