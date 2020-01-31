//
//  ViewController.swift
//  QRCodeGenerate
//
//  Created by Manaswi Daksha on 12/19/19.
//  Copyright © 2019 Manaswi Daksha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toViewQR(_ sender: Any) {
        performSegue(withIdentifier: "toSecond", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            if let vc = segue.destination as? SecondViewController {
                if inputTextField.text != "" {
                    vc.qrReceiver = qrConverter(inputTextField.text!)
                } else {
                    vc.qrReceiver = qrConverter(UIImage(named: "usercat")!)
                }
                
            }
        }
    }
    
    func qrConverter(_ input: String) -> UIImage? {
        let data = input.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func qrConverter(_ input: UIImage) -> UIImage? {
        
        let mySize = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(mySize, false, 0)
        input.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let imageData = image!.jpegData(compressionQuality: 0.1) else { return nil }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(imageData, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}

