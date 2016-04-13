//
//  LoadingView.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/12/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(spinner)
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attachToView(view: UIView) {
        self.alpha = 0
        self.frame = view.bounds
        view.addSubview(self)
        spinner.startAnimating()
        self.setNeedsLayout()
        UIView.animateWithDuration(0.3) { () -> Void in
            self.alpha = 1.0
        }
    }
    
    func remove() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha = 0
            }) { (complete) -> Void in
                self.removeFromSuperview()
                self.spinner.stopAnimating()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.anchorInCenter(width: 40, height: 40)
    }
}
