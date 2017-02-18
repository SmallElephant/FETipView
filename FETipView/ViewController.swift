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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    @IBAction func tipAction(_ sender: UIButton) {
        
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.center.x, y: sender.frame.maxY)
        preference.drawing.message = "《道德经》是春秋时期老子（李耳）的哲学作品，又称《道德真经》、《老子》、《五千言》、《老子五千文》-FlyElephant"
        preference.animating.shouldDismiss = false
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }
    
    @IBAction func downAction(_ sender: UIButton) {
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.center.x, y: sender.frame.minY)
        preference.positioning.arrowPosition = UIPopoverArrowDirection.down
        preference.animating.shouldDismiss = false

        preference.drawing.message = "《颜氏家训》是汉民族历史上第一部内容丰富，体系宏大的家训，也是一部学术著作。作者颜之推，是南北朝时期著名的文学家、教育家。-FlyElephant"
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }

    @IBAction func leftAction(_ sender: UIButton) {
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.frame.maxX, y: sender.center.y)
        preference.positioning.arrowPosition = UIPopoverArrowDirection.left
        preference.animating.shouldDismiss = false

        preference.drawing.message = "理想国-FlyElephant"
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        var preference:FEPreferences = FEPreferences()
        preference.positioning.targetPoint = CGPoint(x: sender.frame.minX, y: sender.center.y)
        preference.positioning.arrowPosition = UIPopoverArrowDirection.right
        preference.animating.shouldDismiss = false
        
        preference.drawing.message = "《解忧杂货店》是日本作家东野圭吾写作的奇幻温情小说。2011年于《小说野性时代》连载，于2012年3月由角川书店发行单行本。该书讲述了在僻静街道旁的一家杂货店，只要写下烦恼投进店前门卷帘门的投信口，第二天就会在店后的牛奶箱里得到回答：因男友身患绝症，年轻女孩月兔在爱情与梦想间徘徊；松冈克郎为了音乐梦想离家漂泊，却在现实中寸步难行；少年浩介面临家庭巨变，挣扎在亲情与未来的迷茫中……他们将困惑写成信投进杂货店，奇妙的事情随即不断发生"
        
        let tipView:FETipView = FETipView(preferences: preference)
        tipView.show()
    }

}

