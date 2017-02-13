//
//  FETipView.swift
//  FETipView
//
//  Created by FlyElephant on 17/2/8.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

import Foundation
import UIKit

public struct FEPreferences {
    
    public struct Drawing {
        public var cornerRadius        = CGFloat(5)
        public var arrowHeight         = CGFloat(8)
        public var arrowWidth          = CGFloat(10)
        
        public var textInset           = CGFloat(8)
        public var maxTextWidth        = CGFloat(180)
        public var maxHeight           = CGFloat(200)
        public var minHeight           = CGFloat(40)
 
        public var backgroundColor     = UIColor.orange

        public var textAlignment       = NSTextAlignment.center
        public var textColor           = UIColor.white
        public var textBackGroundColor = UIColor.clear
        public var borderWidth         = CGFloat(0)
        public var borderColor         = UIColor.clear
        public var font                = UIFont.systemFont(ofSize: 14)
        public var message             = ""
    }
    
    public struct Positioning {
        public var targetPoint         = CGPoint.zero
        public var arrowPosition       = UIPopoverArrowDirection.up
    }
    
    public struct Animating {
        public var showDuration         = 0.3
        public var dismissDuration      = 2.0
        public var dismissOnTap         = true
    }
    
    public var drawing      = Drawing()
    public var positioning  = Positioning()
    public var animating    = Animating()
    public var hasBorder : Bool {
        return drawing.borderWidth > 0 && drawing.borderColor != UIColor.clear
    }
    
    public init() {}
}


class FETipView:UIView {
    
    private let screenWidth:CGFloat = UIScreen.main.bounds.width
    
    private var label:UILabel!
    private var message:String = ""
    private var preference:FEPreferences!
    
    private var arrowHeight:CGFloat = 0
    private var arrowWidth:CGFloat = 0
    private var width:CGFloat = 0
    private var point:CGPoint = .zero
    
    private var textSize:CGSize = .zero
    private var contentSize:CGSize = .zero
    
    
    convenience init(preferences:FEPreferences) {
        self.init()
        self.preference = preferences
        
        point = preference.positioning.targetPoint
        arrowHeight = preference.drawing.arrowHeight
        arrowWidth = preference.drawing.arrowWidth
        width = preference.drawing.maxTextWidth + preference.drawing.textInset * 2
        
        message = preference.drawing.message
        
        self.frame = CGRect(x: point.x - width / 2, y: point.y, width: width, height: preference.drawing.minHeight)
        self.backgroundColor = UIColor.clear
    }
    
    public func show() {
        
        self.computerTextSize()
        
        self.adjustFrame()
        
        let textHInset:CGFloat = ceil(((contentSize.height - arrowHeight) - textSize.height) / 2)
        
        label = UILabel.init(frame: CGRect.init(x:10, y: arrowHeight + textHInset, width: preference.drawing.maxTextWidth, height: textSize.height))
        label.text = message
        label.font = preference.drawing.font
        label.textColor = preference.drawing.textColor
        label.backgroundColor = preference.drawing.textBackGroundColor
        label.textAlignment = preference.drawing.textAlignment
        self.addSubview(label)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        
        UIView.animate(withDuration: preference.animating.showDuration, delay: 0, options: .curveEaseIn, animations: { 
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { (finished:Bool) in
            self.transform = CGAffineTransform.identity
        }
        
       //  self.perform(#selector(self.dismiss), with: nil, afterDelay: self.preference.animating.dismissDuration)
       
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: preference.animating.showDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }

    }
    
    // MARK:-  Private
    
    private func computerTextSize() {
        
        let textInset:CGFloat = preference.drawing.textInset
        let attributes = [NSFontAttributeName : preference.drawing.font]
        
        var textSize = self.message.boundingRect(with: CGSize(width: preference.drawing.maxTextWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        
        let minHeight:CGFloat = preference.drawing.minHeight
        
        
        let retainMinHeight:CGFloat = minHeight - arrowHeight - textInset * 2
        let retainMaxHeight:CGFloat = preference.drawing.maxHeight - arrowHeight - textInset * 2
        
        if textSize.height < retainMinHeight {
            textSize.height = retainMinHeight
        }
        
        if  textSize.height > retainMaxHeight  {
            textSize.height = retainMaxHeight
        }
        
        var contentHeight:CGFloat = textSize.height + arrowHeight + textInset * 2
        
        if textSize.height > retainMinHeight && textSize.height < minHeight {
            contentHeight = minHeight
        }
        
        self.textSize = textSize
        
        self.contentSize = CGSize(width: width, height: contentHeight)
        
    }
    
    private func adjustFrame() {
        var frameX:CGFloat = point.x - width / 2
        if (point.x - width / 2) < 0 {
            frameX = 1
        }
        
        if (point.x + width / 2 > screenWidth) {
            frameX = screenWidth - width - 1
        }
        
        self.frame = CGRect(x: frameX, y: point.y, width: width, height: contentSize.height)
    }
    
    // MARK:- Override
    
    override func draw(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
     //   self.adjustFrame()
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        
        context.setFillColor(preference.drawing.backgroundColor.cgColor)
        context.setStrokeColor(preference.drawing.backgroundColor.cgColor)
     
        let height:CGFloat = preference.drawing.minHeight
        let radius:CGFloat = (contentSize.height - arrowHeight) / 2
        
        let contourPath = CGMutablePath()
        let beginX:CGFloat = point.x - self.frame.origin.x
        
        contourPath.move(to: CGPoint(x: beginX, y: 0))
        
        contourPath.addLine(to: CGPoint(x: beginX - arrowWidth / 2, y: arrowHeight))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: arrowHeight), tangent2End: CGPoint(x: 0, y:height), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: height), tangent2End: CGPoint(x: width, y: height), radius: radius)
        
        contourPath.addArc(tangent1End:CGPoint(x: width, y: height), tangent2End: CGPoint(x: width, y: arrowHeight), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: width, y: arrowHeight), tangent2End: CGPoint(x: 0, y: arrowHeight), radius: radius)
        
        contourPath.addLine(to: CGPoint(x: beginX + arrowWidth / 2, y: arrowHeight))
        
        contourPath.addLine(to: CGPoint(x: beginX, y: 0))
        
        context.addPath(contourPath)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        context.restoreGState()
    }
}

