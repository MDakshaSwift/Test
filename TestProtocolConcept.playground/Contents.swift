import UIKit

protocol LetsWork {}

extension LetsWork {
    func iAmWorking() {
        print("I am Alistar, and I am Working")
    }
}

struct Employee: LetsWork {
    func iAmWorking() {
        print("I am Samantha, and I am Working")
    }
}

let samantha: LetsWork = Employee()
samantha.iAmWorking()


