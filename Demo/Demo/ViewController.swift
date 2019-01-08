//
//  ViewController.swift
//  Demo
//
//  Created by chamsol kim on 30/11/2018.
//  Copyright © 2018 chamsol kimdfsdf. All rights reserved.
//

import UIKit
import Foundation
import UICircularProgressRing

class ViewController: UIViewController {

    var stepIndicatorView: StepIndicatorView!
    var containerView: UIView!
    
    var progressRing: UICircularProgressRing!
    
    var progressBar: CircularProgressBar!
    var count = 0
    
    @IBAction func touch(_ sender: Any) {
        count += 1
        self.progressRing.value = UICircularProgressRing.ProgressValue(integerLiteral: count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view, typically from a nib.
        let stepRect = CGRect(x: 0, y: 0, width: 300, height: 0)
        self.containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: stepRect.size))
        self.containerView.backgroundColor = UIColor.lightGray
        
        // step
        self.stepIndicatorView = StepIndicatorView()
        self.stepIndicatorView.center = self.containerView.center
        self.stepIndicatorView.frame = stepRect
        self.stepIndicatorView.numberOfSteps = 3
        self.stepIndicatorView.currentStep = 2
        self.stepIndicatorView.circleColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        self.stepIndicatorView.circleTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
        self.stepIndicatorView.circleStrokeWidth = 3.0  // 테두리 원 두께
        self.stepIndicatorView.circleRadius = 15.0      // 원 반지름
        self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
        self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
        self.stepIndicatorView.lineMargin = 4.0         // 막대랑 원 사이에 여백
        self.stepIndicatorView.lineStrokeWidth = 2.0    // 진행 막대 두께
        self.stepIndicatorView.displayNumbers = false   // indicates if it displays numbers at the center instead of the core circle
        self.stepIndicatorView.direction = .leftToRight
        
        // circular ring
        self.progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.progressRing.innerRingColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
        self.progressRing.innerRingWidth = 2
        self.progressRing.outerRingWidth = 0
        self.progressRing.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        self.progressRing.font = UIFont.systemFont(ofSize: 10)
        
        self.progressRing.center = CGPoint(x: self.stepIndicatorView.center.x + 81, y: self.stepIndicatorView.center.y)
        
        // add view
        self.containerView.addSubview(self.stepIndicatorView)
        self.containerView.addSubview(self.progressRing)
//        self.view.addSubview(containerView)
        self.navigationItem.titleView = self.containerView
    }


}

