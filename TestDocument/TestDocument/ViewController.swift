//
//  ViewController.swift
//  TestDocument
//
//  Created by chamsol kim on 22/01/2019.
//  Copyright © 2019 chamsol kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var documentVC: UIDocumentPickerViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.'
        documentVC = UIDocumentPickerViewController(documentTypes: [], in: UIDocumentPickerMode.exportToService)
    }

    @IBAction func document(_ sender: Any) {
        self.present(documentVC, animated: true, completion: nil)
    }
    
}

