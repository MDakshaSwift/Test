//
//  ViewController.swift
//  RetainCycleProject
//
//  Created by Manaswi Daksha on 12/16/19.
//  Copyright © 2019 Manaswi Daksha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var objFromA: A?
    var objFromB: B?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        someMethod()
//        assignProperties()
    }
    
    @IBAction func toSecondController(_ sender: Any) {
        performSegue(withIdentifier: "toSecond", sender: sender)
    }
    
    
    
    func someMethod(){
        objFromA = A("Object A", nil) //Reference count: 1
        objFromB = B("Object B", objFromA) //Reference count: 1
    }
    
    func assignProperties(){
        objFromA?.obj = objFromB
        
        objFromB = nil // Reference count: 1
        objFromA = nil // Reference count: 0
        
        //When you have two strongly coupled objects...
        //You have to deinitialize both objects
        //Use delegates/observers/closures
        //Be extremely careful for observers and closures
    }
    
    
    
}

