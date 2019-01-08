//
//  ViewController.swift
//  AirPrint-Test
//
//  Created by chamsol kim on 03/01/2019.
//  Copyright © 2019 chamsol kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPrintInteractionControllerDelegate {

    @IBOutlet weak var printBtn: UIBarButtonItem!
    @IBOutlet weak var subview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func printer(_ sender: Any) {
        let printer = UIPrintInteractionController.shared   // 공유 프린터 인스턴스 생성

        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "jobName"                       // 프린터 이름
        printInfo.outputType = .general                     // 인쇄할 수 있는 컨텐츠 종류
        printInfo.orientation = .portrait                   // 용지방향. portrait, landscape
        
        printer.printInfo = printInfo                       // 프린터 정보
        printer.printingItems = [self.subview.toImage(), self.view.toImage()]          // 인쇄 대상
        printer.showsPaperSelectionForLoadedPapers = true   // 페이지 선택 옵션. 1개만 선택가능하면 안나옴. Default false
        printer.showsNumberOfCopies = true                  // 인쇄 매수 선택 옵션. Default true
        
        printer.present(animated: true, completionHandler: nil)
//        printer.present(from: self.subview.frame, in: self.subview, animated: true, completionHandler: nil)   // 뷰 크기로 생성
//        printer.present(from: printBtn, animated: true, completionHandler: nil)
    }
}

extension UIView {
    // Current View to Image
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
