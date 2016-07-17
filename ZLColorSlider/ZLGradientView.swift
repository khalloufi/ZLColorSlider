//
//  ZLGradientView.swift
//  ZLColorSlider
//
//  Created by issam on 12/07/2016.
//  Copyright © 2016 ZetaLearning. All rights reserved.
//

import UIKit

class ZLGradientView: UIView {
    var colors: Array<UIColor> = [
        UIColor.greenColor(),
        UIColor.redColor(),
        UIColor.blueColor()
    ];
    var index: Int = 0
    var factor: CGFloat = 1.0
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        
        let c1Comp = CGColorGetComponents(UIColor.yellowColor().CGColor)
        let c2Comp = CGColorGetComponents(UIColor.greenColor().CGColor)
        let c3Comp = CGColorGetComponents(UIColor.blueColor().CGColor)
        
        
        var colorComponents = [
            
            c1Comp[0] * (1 - factor) + c2Comp[0] * factor,
            c1Comp[1] * (1 - factor) + c2Comp[1] * factor,
            c1Comp[2] * (1 - factor) + c2Comp[2] * factor,
            c1Comp[3] * (1 - factor) + c2Comp[3] * factor,
            
            c2Comp[0] * (1 - factor) + c3Comp[0] * factor,
            c2Comp[1] * (1 - factor) + c3Comp[1] * factor,
            c2Comp[2] * (1 - factor) + c3Comp[2] * factor,
            c2Comp[3] * (1 - factor) + c3Comp[3] * factor
            
        ]
        
        
        let gradient = CGGradientCreateWithColorComponents(
            CGColorSpaceCreateDeviceRGB(),
            &colorComponents,
            [0.0, 1.0],
            2
        )
        
        CGContextDrawLinearGradient(context,gradient,CGPoint(x: 0.0, y: 0),CGPoint(x: rect.size.width/2, y: 0),CGGradientDrawingOptions(rawValue: 0))
        
        let c11Comp = CGColorGetComponents(UIColor.greenColor().CGColor)
        let c12Comp = CGColorGetComponents(UIColor.blueColor().CGColor)
        let c13Comp = CGColorGetComponents(UIColor.redColor().CGColor)
        
        
        var colorComponents1 = [
            
            c11Comp[0] * (1 - factor) + c12Comp[0] * factor,
            c11Comp[1] * (1 - factor) + c12Comp[1] * factor,
            c11Comp[2] * (1 - factor) + c12Comp[2] * factor,
            c11Comp[3] * (1 - factor) + c12Comp[3] * factor,
            
            c12Comp[0] * (1 - factor) + c13Comp[0] * factor,
            c12Comp[1] * (1 - factor) + c13Comp[1] * factor,
            c12Comp[2] * (1 - factor) + c13Comp[2] * factor,
            c12Comp[3] * (1 - factor) + c13Comp[3] * factor
            
        ]
        
        
        let gradient1 = CGGradientCreateWithColorComponents(
            CGColorSpaceCreateDeviceRGB(),
            &colorComponents1,
            [0.0, 1.0],
            2
        )
        
        CGContextDrawLinearGradient(context,gradient1,CGPoint(x: rect.size.width/2, y: 0),CGPoint(x: rect.size.width, y: 0),CGGradientDrawingOptions(rawValue: 0))
        //CGContextDrawLinearGradient(context,gradient,CGPoint(x: rect.size.width, y: 0.0),CGPoint(x: rect.size.width/2, y: rect.size.height),CGGradientDrawingOptions(rawValue: 0))
        
        CGContextRestoreGState(context);
    }

}
