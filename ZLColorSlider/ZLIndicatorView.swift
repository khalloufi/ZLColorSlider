//
//  ZLIndicatorView.swift
//  ZLColorSlider
//
//  Created by issam on 13/07/2016.
//  Copyright © 2016 ZetaLearning. All rights reserved.
//

import UIKit

class ZLIndicatorView: UIView {
    var colorView:UIView!
    var arrowView:UIView!
    var color:UIColor = UIColor.clearColor(){
        didSet{
            colorView.backgroundColor = color
        }
    }
    override init(frame: CGRect) {
       super.init(frame: frame)
        colorView = UIView(frame: CGRectInset(self.bounds, 3, 3))
        colorView.layer.cornerRadius = CGRectGetWidth(colorView.frame)/2
        addSubview(colorView)
        
        arrowView = UIView(frame: CGRectMake(0, 0, 19, 18))
        var rect:CGRect = arrowView.frame
        rect.origin.y = CGRectGetHeight(self.bounds) - 15
        rect.origin.x = CGRectGetMidX(self.bounds) - round(CGRectGetWidth(arrowView.frame)/2)
        
        arrowView.frame = rect
        arrowView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2)/2)
        arrowView.layer.cornerRadius = 4
        
        addSubview(arrowView)
        sendSubviewToBack(arrowView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func tintColorDidChange() {
        self.backgroundColor = self.tintColor;
        arrowView.backgroundColor = self.tintColor;
    }
}
