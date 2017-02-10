//
//  FETipView.swift
//  FETipView
//
//  Created by FlyElephant on 17/2/8.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

import Foundation
import UIKit

class FETipView:UIView {
    
    let TRIANGLEWIDTH:CGFloat = 10.0
    let TRIANGLEHEIGHT:CGFloat = 10.0
    
    var message:String = ""
    var label:UILabel!
    
    convenience init(message:String!, point:CGPoint) {
        self.init()
        self.message = message
        self.frame = CGRect.init(x: point.x, y: point.y + 20, width: 200, height: 50)
        self.backgroundColor = UIColor.white
    }
    
    
    public func show() {
        label = UILabel.init(frame: CGRect.init(x: 0, y: TRIANGLEHEIGHT, width: 200, height: 40))
        label.text = self.message
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.gray
    //    label.layer.borderColor = UIColor.red.cgColor
      //  label.layer.borderWidth = 1.0
       // self.addSubview(label)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished:Bool) in
            self.transform = CGAffineTransform.identity
        }
        

        
    }
    
    private func dismiss() {
        
    }
    
    //MARK: - Override
    
    override func draw(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setFillColor(UIColor.red.cgColor)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(1.0)
        
        
        let contourPath = CGMutablePath()
        contourPath.move(to: CGPoint(x: 100, y: 0))
        
        contourPath.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))

        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 20.0)
      
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 20.0)
        
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 20.0)
        
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT), radius: 20.0)
        
        contourPath.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        contourPath.addLine(to: CGPoint(x: 100, y: 0))
        context.addPath(contourPath)
        
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        context.restoreGState()
    }
    
     func draw7(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setFillColor(UIColor.orange.cgColor)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(3.0)
        
        
        let contourPath = CGMutablePath()
        contourPath.move(to: CGPoint(x: 100, y: 0))
        
        contourPath.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 20.0)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 20.0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 20.0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 0, y: 10), radius: 20.0)
        
        contourPath.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        contourPath.addLine(to: CGPoint(x: 100, y: 0))
        context.addPath(contourPath)
        context.strokePath()
        
        context.restoreGState()
    }
    
    
    func draw6(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setFillColor(UIColor.orange.cgColor)
        //context.setStrokeColor(UIColor.red.cgColor)
        
        let contourPath = CGMutablePath()
        contourPath.move(to: CGPoint(x: 100, y: 0))
        
        contourPath.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 5.0)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 5.0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 5.0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 0, y: 10), radius: 5.0)
        
        contourPath.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        context.addPath(contourPath)
        context.fillPath()
        
        context.restoreGState()
    }
    
    func draw5(_ rect: CGRect) {
        
        let path:UIBezierPath = UIBezierPath.init()
        
        path.move(to: CGPoint(x: 100, y: 0))
        
        path.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        path.move(to:CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))

        
        path.addLine(to: CGPoint(x: 0, y: 10))
        
        
        
        path.move(to: CGPoint(x: 0, y: 10))
        path.addQuadCurve(to: CGPoint(x: 0, y: 50), controlPoint: CGPoint(x: 0, y: 30))
        
        path.move(to: CGPoint(x: 0, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 50))
        
        path.move(to: CGPoint(x: 200, y: 50))
        path.addQuadCurve(to: CGPoint(x: 200, y: 10), controlPoint: CGPoint(x: 200, y: 30))
        
        path.move(to: CGPoint(x: 200, y: 10))
        path.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        path.move(to:CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        path.addLine(to: CGPoint(x: 100, y: 0))
        
        path.close()
        UIColor.blue.set()
        path.fill()
        
        UIColor.red.set()
        path.lineWidth = 3.0
        path.stroke()
    }
    
     func draw4(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
     //   context.setFillColor(UIColor.orange.cgColor)
        context.setStrokeColor(UIColor.red.cgColor)
        
        let contourPath = CGMutablePath()
        contourPath.move(to: CGPoint(x: 100, y: 0))
        
        contourPath.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 0, y: 10), radius: 0)
        
        contourPath.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        context.addPath(contourPath)
        
       // context.fillPath()
        context.strokePath()
        
        context.restoreGState()
    }
    
    func draw3(_ rect: CGRect) {
        super.draw(rect)
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()!
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 50))
        path.addLine(to: CGPoint(x: 0, y: 50))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        context.addPath(path)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.orange.cgColor)
        context.fillPath()
        
        context.setLineWidth(10)
        context.strokePath()
 
        
    }
    
     func draw2(_ rect: CGRect) {

        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setFillColor(UIColor.white.cgColor)
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 100, y: 0))
        
        context.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        context.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 5.0)
        context.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 5.0)
        context.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 5.0)
        context.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 0, y: 10), radius: 5.0)
        
        context.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        context.closePath()
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        context.restoreGState()
        
    }
    
     func draw1(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        //context.setFillColor(UIColor.orange.cgColor)
        context.setStrokeColor(UIColor.red.cgColor)
        
        let contourPath = CGMutablePath()
        contourPath.move(to: CGPoint(x: 100, y: 0))
        
       contourPath.addLine(to: CGPoint(x: 100 - TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 10), tangent2End: CGPoint(x: 0, y: 50), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 0, y: 50), tangent2End: CGPoint(x: 200, y: 50), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 10), radius: 0)
        contourPath.addArc(tangent1End:CGPoint(x: 200, y: 10), tangent2End: CGPoint(x: 0, y: 10), radius: 0)
        
       contourPath.addLine(to: CGPoint(x: 100 + TRIANGLEWIDTH / 2, y: TRIANGLEHEIGHT))
        
        context.addPath(contourPath)
        context.fillPath()
        
        context.restoreGState()

    }
}
