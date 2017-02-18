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
        public var maxHeight           = CGFloat(160)
        public var minHeight           = CGFloat(40)
 
        public var backgroundColor     = UIColor.orange

        public var textAlignment       = NSTextAlignment.center
        public var textColor           = UIColor.white
        public var textBackGroundColor = UIColor.clear
        public var font                = UIFont.systemFont(ofSize: 14)
        public var message             = ""
        
        public var borderWidth         = CGFloat(1)
        public var borderColor         = UIColor.clear
        public var hasBorder           = false
    }
    
    public struct Positioning {
        public var targetPoint         = CGPoint.zero
        public var arrowPosition       = UIPopoverArrowDirection.up
    }
    
    public struct Animating {
        public var showDuration         = 0.25
        public var delayDuration        = 2.0
        public var dismissDuration      = 0.25
        public var shouldDismiss        = true
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
    private let screenHeight:CGFloat = UIScreen.main.bounds.height
    
    private var label:UILabel!
    private var message:String = ""
    private var preference:FEPreferences!
    
    private var arrowHeight:CGFloat = 0
    private var arrowWidth:CGFloat = 0
    private var width:CGFloat = 0
    private var point:CGPoint = .zero
    
    private var textSize:CGSize = .zero
    private var contentSize:CGSize = .zero
    
    private lazy var contenLabel:UILabel = {
        var   label:UILabel = UILabel.init()
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    convenience init(preferences:FEPreferences) {
        self.init()
        self.preference = preferences
        
        point = preference.positioning.targetPoint
        arrowHeight = preference.drawing.arrowHeight
        arrowWidth = preference.drawing.arrowWidth
        
        switch preference.positioning.arrowPosition {
        case UIPopoverArrowDirection.up,UIPopoverArrowDirection.down:
              width = preference.drawing.maxTextWidth + preference.drawing.textInset * 2
        case UIPopoverArrowDirection.left,UIPopoverArrowDirection.right:
            width = preference.drawing.maxTextWidth + preference.drawing.textInset * 2 + arrowWidth
        default:
            width = preference.drawing.maxTextWidth
        }
      
        
        message = preference.drawing.message
        
        self.frame = CGRect(x: point.x - width / 2, y: point.y, width: width, height: preference.drawing.minHeight)
        self.backgroundColor = UIColor.clear
    }
    
    public func show() {
        
        self.computerTextSize()
        
        self.adjustFrame()
        
        self.contenLabel.text = message
        self.contenLabel.font = preference.drawing.font
        self.contenLabel.textColor = preference.drawing.textColor
        self.contenLabel.backgroundColor = preference.drawing.textBackGroundColor
        self.contenLabel.textAlignment = preference.drawing.textAlignment
        
        self.addSubview(contenLabel)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        
        UIView.animate(withDuration: preference.animating.showDuration, delay: 0, options: .curveEaseIn, animations: { 
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { (finished:Bool) in
            self.transform = CGAffineTransform.identity
        }
        
        if preference.animating.shouldDismiss {
             self.perform(#selector(self.dismiss), with: nil, afterDelay: self.preference.animating.delayDuration)
        }
       
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: preference.animating.dismissDuration, delay: 0, options: .curveEaseInOut, animations: {
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
        
        var retainMinHeight:CGFloat = 0
        var retainMaxHeight:CGFloat = 0
        
        switch preference.positioning.arrowPosition {
            
        case UIPopoverArrowDirection.up,UIPopoverArrowDirection.down:
            retainMinHeight = minHeight - arrowHeight - textInset * 2
            retainMaxHeight = preference.drawing.maxHeight - arrowHeight - textInset * 2
            break
        case UIPopoverArrowDirection.left,UIPopoverArrowDirection.right:
            retainMinHeight = minHeight - textInset * 2
            retainMaxHeight = preference.drawing.maxHeight - textInset * 2
            break
        default:
            break
            
        }
        
        if textSize.height < retainMinHeight {
            textSize.height = retainMinHeight
        }
        
        if  textSize.height > retainMaxHeight  {
            textSize.height = retainMaxHeight
        }
        
        var contentHeight:CGFloat = 0
        
        switch preference.positioning.arrowPosition {
            
        case UIPopoverArrowDirection.up,UIPopoverArrowDirection.down:
            contentHeight = textSize.height + arrowHeight + textInset * 2
            break
        case UIPopoverArrowDirection.left,UIPopoverArrowDirection.right:
            contentHeight = textSize.height + textInset * 2
            break
        default:
            break
            
        }
    
        if textSize.height > retainMinHeight && textSize.height < minHeight {
            contentHeight = minHeight
        }

        self.textSize = textSize
        
        self.contentSize = CGSize(width: width, height: contentHeight)
        
    }
    
    private func adjustFrame() {
        switch preference.positioning.arrowPosition {
            
        case UIPopoverArrowDirection.up,UIPopoverArrowDirection.down:
            adjustDirectionUpDown()
            
        case UIPopoverArrowDirection.left,UIPopoverArrowDirection.right:
            adjustDirectionLeftRight()
        default:
            break
        }
    }
    
    private func adjustDirectionUpDown() {
        var frameX:CGFloat = point.x - width / 2
        var frameY:CGFloat = point.y
        let textHInset:CGFloat = ceil(((contentSize.height - arrowHeight) - textSize.height) / 2)
        
        var contentY:CGFloat = textHInset
        
        if (point.x - width / 2) < 0 {
            frameX = 1
        }
        
        if (point.x + width / 2 > screenWidth) {
            frameX = screenWidth - width - 1
        }
        
        switch preference.positioning.arrowPosition {
        case UIPopoverArrowDirection.up:
            contentY = arrowHeight + textHInset
            break
        case UIPopoverArrowDirection.down:
            frameY = point.y - contentSize.height
            break
        default:
            break
        }
        
        self.contenLabel.frame = CGRect.init(x: preference.drawing.textInset, y: contentY, width: preference.drawing.maxTextWidth, height: textSize.height)
        
        self.frame = CGRect(x: frameX, y: frameY, width: width, height: contentSize.height)
    }
    
    private func adjustDirectionLeftRight() {
        var frameX:CGFloat = point.x
        var frameY:CGFloat = point.y - contentSize.height / 2
        
        var contentX:CGFloat = preference.drawing.textInset

        switch preference.positioning.arrowPosition {
        case UIPopoverArrowDirection.left:
            frameX = point.x
            contentX = arrowWidth +  preference.drawing.textInset
            break
        case UIPopoverArrowDirection.right:
            frameX = point.x - width
            contentX = preference.drawing.textInset
            break
        default:
            break
        }
        
        if (point.y - contentSize.height / 2) < 0 {
            frameY = 1
        }
        
        if (point.y + contentSize.height / 2 > screenHeight) {
            frameY = screenHeight - contentSize.height - 1
        }
        
        self.contenLabel.frame = CGRect.init(x:contentX, y: preference.drawing.textInset, width: preference.drawing.maxTextWidth, height: textSize.height)
        
        self.frame = CGRect(x: frameX, y: frameY, width: width, height: contentSize.height)
    }
    
    // MARK:- Override
    
    override func draw(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }

        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        context.setFillColor(preference.drawing.backgroundColor.cgColor)
        context.setStrokeColor(preference.drawing.backgroundColor.cgColor)
        
        let contourPath = CGMutablePath()
        
        switch preference.positioning.arrowPosition {
            case UIPopoverArrowDirection.up:
              drawArrowUp(contourPath: contourPath)
            break
            case UIPopoverArrowDirection.down:
             drawArrowDown(contourPath: contourPath)
            break
            case UIPopoverArrowDirection.left:
             drawArrowLeft(contourPath: contourPath)
            break
            case UIPopoverArrowDirection.right:
            drawArrowRight(contourPath: contourPath)
            break
            
           default:
           break
        }
      
        context.addPath(contourPath)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        if preference.drawing.hasBorder {
            drawBorder(borderPath: contourPath, context: context)
        }
        
        context.restoreGState()
    }
    
    private func drawArrowUp(contourPath:CGMutablePath) {
        let height:CGFloat = contentSize.height
        let radius:CGFloat = preference.drawing.cornerRadius
        
        let beginX:CGFloat = point.x - self.frame.origin.x
        
        contourPath.move(to: CGPoint(x: beginX, y: 0))
        
        contourPath.addLine(to: CGPoint(x: beginX - arrowWidth / 2, y: arrowHeight))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: arrowHeight), tangent2End: CGPoint(x: 0, y:height), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: height), tangent2End: CGPoint(x: width, y: height), radius: radius)
        
        contourPath.addArc(tangent1End:CGPoint(x: width, y: height), tangent2End: CGPoint(x: width, y: arrowHeight), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: width, y: arrowHeight), tangent2End: CGPoint(x: 0, y: arrowHeight), radius: radius)
        
        contourPath.addLine(to: CGPoint(x: beginX + arrowWidth / 2, y: arrowHeight))
        
        contourPath.addLine(to: CGPoint(x: beginX, y: 0))
    }
    
    private func drawArrowDown(contourPath:CGMutablePath) {
        let contentHeight:CGFloat = contentSize.height
        let radius:CGFloat = preference.drawing.cornerRadius
        
        let beginX:CGFloat = point.x - self.frame.origin.x
        
        let height:CGFloat = contentHeight - arrowHeight
        
        contourPath.move(to: CGPoint(x: beginX, y: contentHeight))
        
        contourPath.addLine(to: CGPoint(x: beginX - arrowWidth / 2, y: height))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: height), tangent2End: CGPoint(x: 0, y: 0), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: width, y: 0), radius: radius)
        
        contourPath.addArc(tangent1End:CGPoint(x: width, y: 0), tangent2End: CGPoint(x: width, y: height), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: width, y: height), tangent2End: CGPoint(x: 0, y: height), radius: radius)
        
        contourPath.addLine(to: CGPoint(x: beginX + arrowWidth / 2, y: height))
        
        contourPath.addLine(to: CGPoint(x: beginX, y: contentHeight))
    }
    
    private func drawArrowLeft(contourPath:CGMutablePath) {
        let contentHeight:CGFloat = contentSize.height
        let radius:CGFloat = preference.drawing.cornerRadius
        
        let beginY:CGFloat = point.y - self.frame.origin.y
        
        contourPath.move(to: CGPoint(x: 0, y: beginY))
        
        contourPath.addLine(to: CGPoint(x: arrowWidth, y: beginY - arrowHeight / 2))
        
        contourPath.addArc(tangent1End:CGPoint(x: arrowWidth, y: 0), tangent2End: CGPoint(x: width, y: 0), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: width, y: 0), tangent2End: CGPoint(x: width, y: contentHeight), radius: radius)
        
        contourPath.addArc(tangent1End:CGPoint(x: width, y: contentHeight), tangent2End: CGPoint(x: arrowWidth, y: contentHeight), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: arrowWidth, y: contentHeight), tangent2End: CGPoint(x: arrowWidth, y: 0), radius: radius)
        
        contourPath.addLine(to: CGPoint(x: arrowWidth, y: beginY + arrowHeight / 2))
        
        contourPath.addLine(to: CGPoint(x: 0, y: beginY))
    }
    
    private func drawArrowRight(contourPath:CGMutablePath) {
        let contentHeight:CGFloat = contentSize.height
        let radius:CGFloat = preference.drawing.cornerRadius
        
        let beginY:CGFloat = point.y - self.frame.origin.y
        
        
        let pathWidth:CGFloat = width - arrowWidth
        
        contourPath.move(to: CGPoint(x: width, y: beginY))
        
        contourPath.addLine(to: CGPoint(x: pathWidth, y: beginY - arrowHeight / 2))
        
        contourPath.addArc(tangent1End:CGPoint(x: pathWidth, y: 0), tangent2End: CGPoint(x: 0, y: 0), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: 0, y: contentHeight), radius: radius)
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: contentHeight), tangent2End: CGPoint(x: pathWidth, y: contentHeight), radius: radius)
        contourPath.addArc(tangent1End:CGPoint(x: pathWidth, y: contentHeight), tangent2End: CGPoint(x: pathWidth, y: 0), radius: radius)
        
        contourPath.addLine(to: CGPoint(x: pathWidth, y: beginY + arrowHeight / 2))
        
        contourPath.addLine(to: CGPoint(x: width, y: beginY))
    }
    
    private func drawBorder(borderPath: CGPath, context: CGContext) {
        context.addPath(borderPath)
        context.setStrokeColor(preference.drawing.borderColor.cgColor)
        context.setLineWidth(preference.drawing.borderWidth)
        context.strokePath()
    }
    
    
}

