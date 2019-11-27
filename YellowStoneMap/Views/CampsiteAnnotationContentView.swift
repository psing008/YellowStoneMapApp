//
//  CampsiteAnnotationContentView.swift
//  YellowStoneMap
//
//  Created by Piyush Singh on 11/27/19.
//  Copyright © 2019 Piyush. All rights reserved.
//

import Foundation
import UIKit

class CampsiteAnnotationContentView: UIView {
    
    var imageView: UIImageView = UIImageView()
    var textLabel: UILabel = UILabel()
    
    convenience init(imageName: String, title: String?) {
        self.init(frame: CGRect.zero)
        
        imageView = UIImageView(image: UIImage(named: imageName))
        addSubview(self.imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = title
        textLabel.font = UIFont.systemFont(ofSize: 10)
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(frame: CGRect.zero)
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        addSubview(stackView)
        stackView.alignment = .center
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
