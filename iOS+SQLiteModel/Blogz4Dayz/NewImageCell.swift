//
//  NewImageCell.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/9/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import UIKit

class NewImageCell: UICollectionViewCell {

    let label = UILabel()
    let view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.clearColor()
        
        label.text = "+"
        label.font = UIFont.systemFontOfSize(48.0)
        label.textColor = color
        label.textAlignment = .Center
        label.clipsToBounds = true
        
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 30.0
        
        self.contentView.addSubview(view)
        view.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.anchorInCenter(width: 60, height: 60)
        label.fillSuperview(left: 0, right: 0, top: 0, bottom: 8)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
