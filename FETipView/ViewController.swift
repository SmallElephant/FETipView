//
//  ViewController.swift
//  FETipView
//
//  Created by FlyElephant on 17/2/8.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var shakeView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 文本顶部三角箭头的位置
        // 文本距离上下左右的边距
        // 自定义弹出动画
        // 箭头方向
        
        self.shakeView = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 40))
        self.shakeView.backgroundColor = UIColor.red
        self.shakeView.layer.masksToBounds = true
        self.shakeView.layer.cornerRadius = 20.0
        
        self.shakeView.layer.shadowColor = UIColor.green.cgColor
        self.shakeView.layer.shadowRadius = 20
            
            
        self.view.addSubview(self.shakeView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    @IBAction func tipAction(_ sender: UIButton) {
        
       // let tipView:FETipView = FETipView.init(message: "新手注册，多多指导", point: CGPoint.init(x: sender.center.x, y: sender.frame.maxY))
        
        //tipView.show()
        
        //设置抖动幅度

//        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        animation.fromValue = -0.06
//        animation.toValue = 0.06
//        animation.duration = 0.06
//        animation.autoreverses = false //是否重复 恢复原样
//        animation.repeatCount = 4
//        animation.fillMode = kCAFillModeForwards
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//      //  animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.24, 0.9, 1.0, 0.0)
//        self.shakeView.layer.add(animation, forKey: "shake")
        
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.center.x, y: sender.frame.maxY)
       // preference.drawing.textBackGroundColor = UIColor.gray
        preference.drawing.message = "《解忧杂货店》是日本作家东野圭吾写作的奇幻温情小说。2011年于《小说野性时代》连载，于2012年3月由角川书店发行单行本。该书讲述了在僻静街道旁的一家杂货店，只要写下烦恼投进店前门卷帘门的投信口，第二天就会在店后的牛奶箱里得到回答：因男友身患绝症，年轻女孩月兔在爱情与梦想间徘徊；松冈克郎为了音乐梦想离家漂泊，却在现实中寸步难行；少年浩介面临家庭巨变，挣扎在亲情与未来的迷茫中……他们将困惑写成信投进杂货店，奇妙的事情随即不断发生"
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }
    
    @IBAction func downAction(_ sender: UIButton) {
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.center.x, y: sender.frame.minY)
        preference.positioning.arrowPosition = UIPopoverArrowDirection.down
        // preference.drawing.textBackGroundColor = UIColor.gray
        preference.drawing.message = "《解忧杂货店》是日本作家东野圭吾写作的奇幻温情小说。2011年于《小说野性时代》连载，于2012年3月由角川书店发行单行本。该书讲述了在僻静街道旁的一家杂货店，只要写下烦恼投进店前门卷帘门的投信口，第二天就会在店后的牛奶箱里得到回答：因男友身患绝症，年轻女孩月兔在爱情与梦想间徘徊；松冈克郎为了音乐梦想离家漂泊，却在现实中寸步难行；少年浩介面临家庭巨变，挣扎在亲情与未来的迷茫中……他们将困惑写成信投进杂货店，奇妙的事情随即不断发生"
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }
    

}

