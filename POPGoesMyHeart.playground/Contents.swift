import UIKit

//MARK: - Protocol-oriented programming

/*
 POP uses nearly all the same tools you would use with OOP
 It keeps the principles of encapsulation and polymorphism
 BUT it does away with inheritance
 
 
 This helps you build your app architecture horizontally instead of vertically
 You add functionality by adopting protocols rather than inheriting from parent classes
 */


//A protocol is a promise of functionality: the compiler will ensure that anyone
//who wants to conform to the protocol must implement all the methods you specify

//protocol Payable {
//    func calculateWages() -> Int
//}

//Extensions allow you to add functionality to specific types. For example,
//you can add a squared() method to integers like this:

//extension Int {
//    func squared() -> Int {
//        return self * self
//    }
//}
//
//5.squared()

//Disadvantages of Protoccols: They can only contain declarations of methods
//Disadvantages of Extensions: They only apply to specific data types
    //Code like above only works for Int but not UInt for example...

/*
 Protocol extensions combine the two: they let you provide complete default implementations for functions
 in the same way as extensions, but apply at the protocol level rather than the individual type level
 */

//extension BinaryInteger {
//    func squared() -> Self {
//        return self * self
//    }
//}

//These implementations are default... they can be overriden if need be...
//Self with a capital s means: "return whatever data type I'm being used with"

//MARK: - Protocol extensions in detail

/*
 You need to separate creating the protocol and adding functionality.
 We declared Payable above
 */

//extension Payable {
//    func calculateWages() -> Int {
//        return 10000
//    }
//}

/*
 ObjC is not aware of any protocol extensions you build, which means you can't create extensions for UIKit protocols
 @obc protocols will ignore all your extensions!
 */

//To test the extension out, we do the following:
//struct Surgeon { }

//extension Surgeon: Payable { }

//let gregory = Surgeon()
//
//extension Surgeon: Payable {
//    func calculateWages() -> Int {
//        return 20000
//    }
//}

//gregory.calculateWages()
//
//let doogie: Payable = Surgeon() //doogie is being stored as a Payable
//doogie.calculateWages()

//This is a polymorphism... BUT it matters: when there is no protocol declaration of a method,
//Swift will decide which method to call based on the data type it sees.


/*
 IMPORTANT: Including a method in a protocol declaration is the signal to Swift that we want to allow
 any default implementations to be overridden in the situations when we refer to an instance by one of its
 protocols rather than its specific type.
 */


//MARK: - Thinking Horizontally

/*
 POP:
 Horizontal architecture is using whichever protocols make sense to add specific pieces of functionality.
 When you switch to protocols, you can adopt as many protocols as you need
 
 This is a huge difference: Rather than your superclasses dictating what methods their child classes will receive
 - a process that could easily result in complex, fragile hierarchies
 - the child classes dictate what functionality they want to bring in by selectively adding the protocols they want
 Bonus: Protocols can be adopted by enums, classes and structs
 
 !!! Protocols only let you add methods and computed properties, not stored properties !!!
 This keeps complexity low
 */

//MARK: - POP In Practice

protocol Payable {
    func calculateWages() -> Int
}

extension Payable {
    func calculateWages() -> Int {
        return 10000
    }
}

protocol ProvidesTreatment {
    func treat(name: String)
}

extension ProvidesTreatment {
    func treat(name: String) {
        print("I have treated \(name)")
    }
}

protocol ProvidesDiagnosis {
    func diagnose() -> String
}

extension ProvidesDiagnosis {
    func diagnose() -> String {
        return "He's dead, Jim"
    }
}

protocol ConductsSurgery {
    func performSurgery()
}

extension ConductsSurgery {
    func performSurgery() {
        print("Success!")
    }
}

protocol HasRestTime {
    func takeBreak()
}

extension HasRestTime {
    func takeBreak() {
        print("Time to watch TV")
    }
}

protocol NeedsTraining {
    func study()
}

extension NeedsTraining {
    func study() {
        print("I'm reading a book")
    }
}

/*
 We're going to define four roles: receptionist, nurse, doctor, and surgeon
 */

struct Receptionist { }
struct Nurse { }
struct Doctor { }
struct Surgeon { }

/*
 We give each role some functionality
 */

//extension Receptionist: Payable, HasRestTime, NeedsTraining { }
//extension Nurse: Payable, HasRestTime, NeedsTraining, ProvidesTreatment { }
//extension Doctor: Payable, HasRestTime, NeedsTraining, ProvidesTreatment, ProvidesDiagnosis { }
//extension Surgeon: Payable, HasRestTime, NeedsTraining, ProvidesDiagnosis, ConductsSurgery { }

protocol Employee: Payable, HasRestTime, NeedsTraining { }

extension Receptionist: Employee { }
extension Nurse: Employee, ProvidesTreatment { }
extension Doctor: Employee, ProvidesDiagnosis, ProvidesTreatment { }
extension Surgeon: Employee, ProvidesDiagnosis, ConductsSurgery { }


extension Employee where Self: ProvidesTreatment {
    func checkInsurance() {
        print("Yup, I'm totally insured")
    }
}

extension Collection where Iterator.Element: BinaryInteger {
    func countOddEven() -> (odd: Int, even: Int) {
        var even = 0
        var odd = 0
        
        for val in self {
            if val % 2 == 0 {
                even += 1
            } else {
                odd += 1
            }
        }
        return (odd: odd, even: even)
    }
}

//Example One: Squaring Integers

extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

//Example Two: Clamping Integers

extension BinaryInteger {
    func clamp(low: Self, high: Self) -> Self {
        return min(max(self, low), high)
    }
}

//Example Three: Matching Value Types

extension Equatable {
    func matches(array items: [Self]) -> Bool {
        for item in items {
            if item != self {
                return false
            }
        }
        return true
    }
}


//Example Four: Comparing Arrays

extension Comparable {
    func lessThan(array items: [Self]) -> Bool {
        for item in items {
            if item <= self {
                return false
            }
        }
        return true
    }
}

//Example Five: Rewriting Contains()
//The type of object that the iterator stores must be equatable

extension Collection where Iterator.Element: Equatable {
    func myContains(element: Iterator.Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
}

//Example Six: Fuzzy Array Matching

extension Collection where Iterator.Element: Comparable{
    func fuzzyMatches(other: Self) -> Bool {
        if other.sorted() == self.sorted() {
            return true
        }
        return false
    }
}

//Example Seven: Average String Length

extension Collection where Iterator.Element == String {
    func averageLength() -> Double {
        var sum = 0
        var count = 0
        
        self.forEach {
            sum += $0.count
            count += 1
        }
        
        return Double(sum) / Double(count)
    }
}

//Example Eight: Counting Integers

extension Collection where Iterator.Element == Int {
    func countOfFive() -> Int {
        var count = 0
        
        self.forEach {
            let number = String(describing: $0)
            number.forEach {
                if $0 == "5" {
                    count += 1
                }
            }
        }
        return count
    }
    
//    func numberOf5s() -> Int {
//        var count = 0
//
//        for item in self {
//            let str = String(item)
//
//            for letter in str {
//                if letter == "5" {
//                    count += 1
//                }
//            }
//        }
//        return count
//    }
    
}


//Example Nine: De-duping an array
extension Array where Element: Equatable {
    func uniqueValues() -> [Element] {
        var result = [Element]()
        
        for item in self {
            if !result.contains(item) {
                result.append(item)
            }
        }
        return result
    }
}

//Example Ten: Array Is Sorted

extension Array where Element: Comparable {
    func isSorted() -> Bool {
        return self == self.sorted()
    }
}

