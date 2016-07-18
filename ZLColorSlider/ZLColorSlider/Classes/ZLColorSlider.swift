//
//  ZLColorSlider.swift
//  ZLColorSlider
//
//  Created by issam on 12/07/2016.
//  Copyright © 2016 ZetaLearning. All rights reserved.
//

import UIKit

class ZLColorSlider: UISlider {
    var indicatorOffset:CGFloat = -25
    var showIndicator:Bool = true
    var colorTrackHeight:Int = 2
    var indicatorApprearAnimationDuration:NSTimeInterval = 0.07
    var indicatorDismissAnimationDuration:NSTimeInterval = 0.06
    var color:UIColor{
        get{
            return UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0)
        }
        set{
            var hue:CGFloat = 0
            color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
            self.value = Float(hue)
        }
    }
    var colorTrackImageView:UIImageView!
    var indicatorView:ZLIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    func initialize() {
        let image:UIImage = UIImage(named: "slider-color.png")!
        colorTrackImageView = UIImageView(image: image)
        addSubview(colorTrackImageView)
        sendSubviewToBack(colorTrackImageView)
        
        setMinimumTrackImage(imageFromColor(UIColor.clearColor()), forState: UIControlState.Normal)
        setMaximumTrackImage(imageFromColor(UIColor.clearColor()), forState: UIControlState.Normal)
        
        self.thumbTintColor = UIColor(hue: 0.5,saturation: 1.0,brightness: 1.0,alpha: 1.0)
        
        indicatorView = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        colorTrackImageView.frame = trackRectForBounds(self.bounds)
        let center:CGPoint = colorTrackImageView.center
        var rect:CGRect = colorTrackImageView.frame
        rect.size.height = CGFloat(colorTrackHeight)
        colorTrackImageView.frame = rect
        colorTrackImageView.center = center
    }

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let tracking:Bool = super.beginTrackingWithTouch(touch, withEvent: event)
        if showIndicator{
            if CGRectContainsPoint(CGRectInset(currentThumbRect(), -8, -8), touch.locationInView(self)){
                if indicatorView == nil {
                    let rect:CGRect = CGRectOffset(CGRectInset(currentThumbRect(), -1, -1), 0, indicatorOffset)
                    indicatorView = previewViewWithFrame(rect, color: UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0))
                    
                    addSubview(indicatorView)
                    UIView.animateWithDuration(indicatorApprearAnimationDuration, animations: {
                        self.indicatorView.alpha = 1
                        self.thumbTintColor = UIColor.clearColor()
                    })
                }
            }
        }
        return tracking
    }
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let cont:Bool = super.continueTrackingWithTouch(touch, withEvent: event)
        if showIndicator{
            if self.tracking{
                if indicatorView == nil {
                    let rect:CGRect = CGRectOffset(CGRectInset(currentThumbRect(), -1, -1), 0, indicatorOffset)
                    indicatorView = previewViewWithFrame(rect, color: UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0))
                    addSubview(indicatorView)
                    UIView.animateWithDuration(indicatorApprearAnimationDuration, animations: {
                        self.indicatorView.alpha = 1
                    })
                }else{
                    var rect:CGRect = self.indicatorView.frame
                    rect.origin.x = CGRectGetMidX(currentThumbRect()) - CGRectGetWidth(rect)/2;
                    indicatorView.frame = rect
                    indicatorView.color = UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0)
                    self.thumbTintColor = UIColor.clearColor()
                }
            }
        }
        return cont
    }
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        if showIndicator{
            removeIndicator()
            self.thumbTintColor = UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0)
        }
    }
    override func cancelTrackingWithEvent(event: UIEvent?) {
        super.cancelTrackingWithEvent(event)
        if showIndicator{
            removeIndicator()
        }

    }
    func removeIndicator() {
        var rect:CGRect = self.indicatorView.frame
        rect.origin.x = CGRectGetMidX(currentThumbRect()) - CGRectGetWidth(rect)/2
        self.indicatorView.frame = rect
        indicatorView.color = UIColor(hue: CGFloat(self.value),saturation: 1.0,brightness: 1.0,alpha: 1.0)
        UIView.animateWithDuration(indicatorDismissAnimationDuration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.indicatorView.alpha = 0.0
        }) { (finished:Bool) in
            if finished{
                self.indicatorView.removeFromSuperview()
                self.indicatorView = nil
            }
        }
    }
    
    func currentThumbRect() -> CGRect {
        return thumbRectForBounds(self.bounds, trackRect: trackRectForBounds(self.bounds), value: self.value)
    }
    func previewViewWithFrame(frame:CGRect?, color:UIColor) -> ZLIndicatorView{
        let indicator:ZLIndicatorView = ZLIndicatorView(frame: frame!)
        indicator.tintColor = UIColor.whiteColor()
        indicator.layer.cornerRadius = CGRectGetWidth(indicator.frame)/2
        indicator.alpha = 0.2
        indicator.color = color
        return indicator
    }
    func imageFromColor(color:UIColor) -> UIImage {
        let rect:CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage;
    }
}
