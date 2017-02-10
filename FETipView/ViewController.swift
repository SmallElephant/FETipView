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
        self.view.addSubview(self.shakeView)
        
        let mp3URL:URL = Bundle.main.url(forResource: "PEP/lesson2_game_end_2_Mr.Turner.mp3", withExtension: "")!
        print("MP3播放路径----\(mp3URL)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    @IBAction func tipAction(_ sender: UIButton) {
        
       // let tipView:FETipView = FETipView.init(message: "新手注册，多多指导", point: CGPoint.init(x: sender.center.x, y: sender.frame.maxY))
        
        //tipView.show()
        
        //设置抖动幅度

        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = -0.05
        animation.toValue = 0.05
        animation.duration = 0.06;
        animation.autoreverses = false //是否重复 恢复原样
        animation.repeatCount = 3
       // animation.fillMode = kCAFillModeForwards
       // animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        //animation.timingFunction = CAMediaTimingFunction(controlPoints: <#T##Float#>, <#T##c1y: Float##Float#>, <#T##c2x: Float##Float#>, <#T##c2y: Float##Float#>)
        self.shakeView.layer.add(animation, forKey: "shake")
    }

}

