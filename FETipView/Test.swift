//
//  Test.swift
//  FETipView
//
//  Created by FlyElephant on 17/2/10.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

import Foundation


import Foundation
import UIKit

public class TKPopoverTipModel:NSObject {
    //https://github.com/teodorpatras/EasyTipView
    public var arrowHeight:CGFloat = 8.0
    public var arrowWidth:CGFloat = 12.0
    
    public var maxTextWith:CGFloat = 180.0
    public var minHeight:CGFloat = 50.0
    public var maxHeight:CGFloat = 200.0
    public var padding:CGFloat = 10.0
    
    public var showDuration:TimeInterval = 0.3
    public var dismissDuration:TimeInterval = 1.0
    
    public var backGroundColor:UIColor = UIColor.orange
    public var textColor:UIColor = UIColor.white
    
    public var message:String = ""
    
    public var targetPoint:CGPoint = .zero
}

class TKPopoverTipView:UIView {
    
    private let screenWidth:CGFloat = UIScreen.main.bounds.width
    
    private var label:UILabel!
    private var message:String = ""
    private var model:TKPopoverTipModel!
    
    private var arrowHeight:CGFloat = 0
    private var arrowWidth:CGFloat = 0
    private var width:CGFloat = 0
    private var point:CGPoint = .zero
    
    private var textSize:CGSize = .zero
    private var contentSize:CGSize = .zero
    
    convenience init(model:TKPopoverTipModel) {
        self.init()
        self.model = model
        
        point = self.model.targetPoint
        arrowHeight = model.arrowHeight
        arrowWidth = model.arrowWidth
        width = self.model.maxTextWith + self.model.padding * 2
        
        message = model.message
        
        self.frame = CGRect(x: point.x - width / 2, y: self.model.targetPoint.y, width: width, height: model.minHeight)
        self.backgroundColor = UIColor.clear
    }
    
    public func show() {
        let padding:CGFloat = self.model.padding
        
        self.computerTextSize()
        
        self.adjustFrame()
        
        let textHInset:CGFloat = ceil(((contentSize.height - arrowHeight) - textSize.height) / 2)
        
        label = UILabel.init(frame: CGRect.init(x:padding, y: arrowHeight + textHInset, width: self.model.maxTextWith, height: textSize.height))
        label.text = self.model.message
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        self.addSubview(label)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = -0.06
        animation.toValue = 0.06
        animation.duration = 0.06
        animation.autoreverses = false //是否重复 恢复原样
        animation.repeatCount = 3
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.layer.add(animation, forKey: "shake")
        
        
        self.perform(#selector(dismiss), with: nil, afterDelay: self.model.dismissDuration)
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: self.model.showDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0
        }) { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
    
    // MARK:-  Private
    
    private func computerTextSize() {
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0)]
        
        var textSize = self.message.boundingRect(with: CGSize(width: self.model.maxTextWith, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        
        let retainMinHeight:CGFloat = self.model.minHeight - arrowHeight - self.model.padding * 2
        let retainMaxHeight:CGFloat = self.model.maxHeight - arrowHeight - self.model.padding * 2
        
        if textSize.height < retainMinHeight {
            textSize.height = retainMinHeight
        }
        
        if  textSize.height > retainMaxHeight  {
            textSize.height = retainMaxHeight
        }
        
        self.textSize = textSize
        
        self.contentSize = CGSize(width: width, height: textSize.height + arrowHeight + self.model.padding * 2)
        
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
        self.adjustFrame()
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setFillColor(self.model.backGroundColor.cgColor)
        context.setStrokeColor(self.model.backGroundColor.cgColor)
        
        let height:CGFloat = self.model.minHeight
        let radius:CGFloat = (height - arrowHeight) / 2
        
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
