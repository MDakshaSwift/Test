//
//  SecondViewController.swift
//  QRCodeGenerate
//
//  Created by Manaswi Daksha on 12/19/19.
//  Copyright © 2019 Manaswi Daksha. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var qrOutput: UIImageView!
    var qrReceiver: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrOutput.image = qrReceiver
    }
    
}
