//
//  SecondViewController.swift
//  TestAnimation
//
//  Created by chamsol kim on 08/01/2019.
//  Copyright © 2019 chamsol kim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var animated: UIView!
    @IBOutlet weak var second: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.second.isHidden = true
        UIView.animate(withDuration: 1,
                       animations: {
                        self.animated.center = CGPoint(x: self.animated.center.x, y: self.animated.center.y + 200)
        }) { (finish) in
            self.second.isHidden = false
        }
        // Do any additional setup after loading the view.
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
