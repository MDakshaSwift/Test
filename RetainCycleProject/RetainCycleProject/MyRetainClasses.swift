//
//  MyRetainClasses.swift
//  RetainCycleProject
//
//  Created by Manaswi Daksha on 12/16/19.
//  Copyright © 2019 Manaswi Daksha. All rights reserved.
//

import Foundation

class A {
    var name: String?
    weak var obj: B?
    
    init(_ name: String?, _ obj: B?){
        self.name = name
        self.obj = obj
    }
    
    //Whenever the object gets realized... All properties get released
    //For the single object!!
    //The retain count in this condition should be one
    //All properties here are strong variables
    
    deinit {
        print("\(String(describing: name)) is being deinitialized")
    }
}

class B {
    var name: String?
    weak var obj: A?
    
    init(_ name: String?, _ obj: A?) {
        self.obj = obj
        self.name = name
    }
    
    deinit {
        print("\(String(describing: name)) is being deinitialized")
    }
}
