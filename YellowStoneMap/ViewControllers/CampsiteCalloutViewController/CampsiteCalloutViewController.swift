//
//  CampsiteCalloutViewController.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/27/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import UIKit

protocol CampsiteCalloutViewControllerDelegate: class {
    func closeCampsiteButtonClicked(identifier:Int)
}

class CampsiteCalloutViewController : UIViewController {
    
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var statusLabel: UILabel!
    var closeCampsiteButton: UIButton!
    var stack: UIStackView!
    
    weak var delegate:CampsiteCalloutViewControllerDelegate?

    lazy var stackViewConstraint:[NSLayoutConstraint] = {
        return [
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: YSAppearence.defaultPadding),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -YSAppearence.defaultPadding),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -YSAppearence.defaultPadding),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: YSAppearence.defaultPadding)
        ]
    }()
    
    lazy var closeCampsiteButtonConstraints:[NSLayoutConstraint] = {
        return [
            closeCampsiteButton.heightAnchor.constraint(equalToConstant: YSAppearence.defaultButtonHeight),
            closeCampsiteButton.widthAnchor.constraint(equalToConstant: YSAppearence.defaultButtonHeight)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        stack = UIStackView(frame: CGRect.zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution  = .fillProportionally
        stack.spacing = 1
        
        nameLabel = UILabel(frame: CGRect.zero)
        descriptionLabel = UILabel(frame: CGRect.zero)
        descriptionLabel.numberOfLines = 0
        statusLabel = UILabel(frame: CGRect.zero)
        
        nameLabel.font = YSAppearence.titleFont
        descriptionLabel.font = YSAppearence.titleFont
        statusLabel.font = YSAppearence.titleFont
        
        closeCampsiteButton = UIButton(type: .custom)
        closeCampsiteButton.setBackgroundImage(UIImage(named: "closeIcon"), for: UIControl.State())
        
        closeCampsiteButton.addTarget(self, action: .buttonTapped, for: UIControl.Event.touchUpInside)
        
        nameLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        statusLabel?.translatesAutoresizingMaskIntoConstraints = false
        closeCampsiteButton?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(statusLabel)
        stack.addArrangedSubview(closeCampsiteButton)
        
        NSLayoutConstraint.activate(stackViewConstraint+closeCampsiteButtonConstraints)
    }
    @objc public  func closeCampsiteButtonClicked(sender: UIButton) {
        delegate?.closeCampsiteButtonClicked(identifier: sender.tag)
    }
}

extension CampsiteCalloutViewController {
    func updateView(model: CampSiteModelProtocol) {
        nameLabel.text = "Name: \(model.name)"
        descriptionLabel.text = "Description: \(model.descriptionText ?? "")"
        descriptionLabel.sizeToFit()
        statusLabel.text = "Status: \(model.status)"
        closeCampsiteButton.tag = model.identifier
        view.setNeedsLayout()
        view.layoutIfNeeded()
        setPreferredContentSizeFromAutolayout()
    }
    
}
fileprivate extension Selector {
    static let buttonTapped = #selector(CampsiteCalloutViewController.closeCampsiteButtonClicked)
}
