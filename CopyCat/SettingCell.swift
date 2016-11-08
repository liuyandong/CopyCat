//
//  SettingCell.swift
//  CopyCat
//
//  Created by YAN DONG LIU on 03/10/2016.
//  Copyright © 2016 YAN DONG LIU. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Setting"
        lb.font = UIFont.systemFont(ofSize: 13)
        return lb
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func setUpViews() {
        // Do something
        super.setUpViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithVisualFormat(format: "H:|-16-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithVisualFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        backgroundColor = UIColor.white
    }
    
}
