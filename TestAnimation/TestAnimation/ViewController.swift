//
//  ViewController.swift
//  TestAnimation
//
//  Created by chamsol kim on 08/01/2019.
//  Copyright © 2019 chamsol kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animated: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    var clicked = false
    @IBAction func animationBtn(_ sender: Any) {
        let defaultCenter = self.animated.center
        if !clicked {
            UIView.animate(withDuration: 1,
                           animations: {
                            self.animated.center = CGPoint(x: defaultCenter.x, y: defaultCenter.y + 200)
            }) { (finish) in
                UIView.animate(withDuration: 1, animations: {
                    self.animated.frame.size = CGSize(width: 100, height: 100)
                    self.animated.center = CGPoint(x: defaultCenter.x, y: defaultCenter.y + 200)
                })
                if finish {
                    self.clicked = true
                }
            }
        } else {
            UIView.animate(withDuration: 1,
                           animations: {
                            self.animated.frame.size = CGSize(width: 150, height: 150)
                            self.animated.center = defaultCenter
            }) { (finish) in
                if finish {
                    UIView.animate(withDuration: 1, animations: {
                        self.animated.center = CGPoint(x: defaultCenter.x, y: defaultCenter.y - 200)
                    })
                }
                self.clicked = false
            }
        }
    }
    
}

