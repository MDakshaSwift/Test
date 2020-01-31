//
//  SecondViewController.swift
//  RetainCycleProject
//
//  Created by Manaswi Daksha on 12/16/19.
//  Copyright © 2019 Manaswi Daksha. All rights reserved.
//

import UIKit

final class Service {
    static let myInstance = Service()
    
    func fetch(_ closure:@escaping (Error?) -> Void) {
        guard let url = URL(string: "https://www.google.com" ) else {return}
        URLSession.shared.dataTask(with: url) {
            (_,_,_) in
            closure(nil)
            return
        }
        
    }
    
    private init() {}
}

class SecondViewController: UIViewController {
    var myClosure: ((Data, Error) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.myInstance.fetch({[unowned self](error) in
            if error != nil {
                print("Success")
            } else {
                print("Failure")
            }
            self.showAlert()
        })
        
//        myClosure = {
//            //Be Very Precise with Your Closures!!
//            [unowned self] (data, error) in
//            self.showAlert()
//        }
        view.backgroundColor = .blue
        //        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Manaswi"), object: nil, queue: .main, using: {[weak self](notification) in
        //            self?.showAlert()
        //        })
        
    }
    
    deinit {
        print("Second View Controller is released from memory!")
//        NotificationCenter.default.removeObserver(self)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
