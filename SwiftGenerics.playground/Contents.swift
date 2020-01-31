/*
 We are going to be working on generic types
 */

/*
 Generic Functions
 */

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//Swift already has the function swap(_:_:)

//Type T is known as a type parameter

/*
 Generic Types
 */

//Generic types are custom classes, structures, and enumerations that can work with any type
//Similar to an Array or Dictionary

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("unos")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()

//Extending a Generic Type
//No need to define the type parameter list (Include <Element>) in the extension

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

let theTop = stackOfStrings.topItem

/*
 Type Constraints:
 When you want to apply generic properties to only a certain set of types
 */


//Type Constraint Syntax

//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U){
//    //function body goes here
//}

//T must be a subclass of SomeClass
//U must conform to the protocol SomeU

//Type Constraint in Action
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//Must define T to conform to Equatable. Otherwise, no access to == for generic type T

/*
 Associated Types
 */

//An associated type gives a placeholder name to a type that is used as part of the protocol
//The actual type to use for that associated type isn't specified until the protocol is adopted

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//The Container protocol defines three required capabilities that it must provide
    //Add a new item to the container with append(_:)
    //Access a count of the items in the container through a count property
    //It must be possible to retrieve each item in the countainer with a subscript


//Stack implementation using Container
struct Stack1<Element>: Container {
    //original Stack1<Element> implementation
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    //conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//Extending an Existing Type to Specify an Associated Type

//In order to extend Array to conform to the Container protocol by:
extension Array: Container {}

//Adding Constraints to an Associated Type
protocol Container1 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Using a Protocol in Its Associated Type's Constraints
    //A protocol can appear as part of its own requirements

protocol SuffixableContainer: Container1 {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}


protocol process {
    func extendPrint()
}

extension process {
    func processprint() {
        print("Hello!")
        
        extendPrint()
    }
}


class Person: process {
    func extendPrint() {
        print("Friends!")
    }
}

class Professor: Person {
    override func extendPrint() {
        print("Pupils!")
    }
}

class Programmer: Professor {
//    func extendPrint() {
//        print("Coders!")
//    }
}

let A = Person()
let B = Professor()
let C = Programmer()

A.processprint()
B.processprint()
C.processprint()

