//
//  ViewController.swift
//  TouchTest
//
//  Created by chamsol kim on 09/12/2018.
//  Copyright © 2018 chamsol kim. All rights reserved.
//

import UIKit

class TestView: UIView {
    /* Hit Test : view 계층에서 가장 앞쪽으로 올라와 있는 view가 무엇인지 알아냄
     * hitTest를 override해서 touch event를 어느 계층의 뷰로 보낼지 결정할 수 있음
     */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 원래 hitTest 메서드로 현재 터치된 곳에서 가장 위에 올라와 있는 view를 가져옴
        var hitTestView = super.hitTest(point, with: event)
        
        // 특정 영역에서만 이벤트를 받도록 함
        /* CGRect
         * inset(by: UIEdgeInsets) : 주어진 edge inset으로 rect를 맞춤
         * insetBy(dx: CGFloat, dy: CGFloat) : 같은 center point를 기준으로 원래 rect의 크기를 바꿈(상하좌우를 dx,dy만큼 변경)
         */
        let touchRect = self.bounds.insetBy(dx: self.bounds.width/3, dy: self.bounds.height/3)
        if touchRect.contains(point) {
            // 가장 위에 있는 뷰가 현재 뷰라면 nil을 반환하도록 함. hitTest가 반환한 뷰에 따라 터치이벤트가 어떻게 이동하는지 알아야 하겠다
            if hitTestView == self {
                hitTestView = nil
            }
        }
        return hitTestView
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    }
    
    @IBAction func switchDidTapped(_ sender: UISwitch) {
        if sender.isOn == true {
            print("Switch On")
        } else {
            print("Switch Off")
        }
    }
}
