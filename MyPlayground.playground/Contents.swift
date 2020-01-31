import UIKit

func addDaysToDate(_ days: Int) -> ((Date) -> Date) {
    let day = days * 24 * 60 * 60
    return {$0.advanced(by: TimeInterval(day))}
}

let toFuture = addDaysToDate(3)
let myDateFromNow = toFuture(Date())
print(myDateFromNow)

let dateFromNow = addDaysToDate(5)(myDateFromNow)


/*
 You have to search all numbers from inclusive 1 to inclusive a given number x, that have the given digit d in it.
The value of d will always be 0 - 9.
The value of x will always be greater than 0.

You have to return as an array

the count of these numbers,
their sum
and their product.

For example:
 x = 11 d = 1 -> Numbers: 1, 10, 11 Return: [3, 22, 110]
If there are no numbers, which include the digit, return [0,0,0].
 */
func digitAnalysis(_ limit: Int64, _ digit: Int64) -> [Int64] {
    var count: Int64 = 0
    var sum: Int64 = 0
    var product: Int64 = 1
    
    (1...limit).forEach({
        if String($0).contains(String(digit)) {
            count += 1
            sum += $0
            product *= $0
        }
    })
    
    if count == 0 {
        return [0,0,0]
    } else {
        return [count, sum, product]
    }
}

func digitAnalysis1(_ limit: Int64, _ digit: Int64) -> [Int64] {
    var count: Int64 = 0
    var sum: Int64 = 0
    var product: Int64 = 1
    
    
    for input in 1...limit {
        if String(input).contains(String(digit)) {
            count += 1
            sum += input
            product *= input
        }
    }
    
    if count == 0 {
        return [0,0,0]
    } else {
        return [count, sum, product]
    }
}


func numbersWithDigitInside( x: Int64,  d: Int64) -> [Int64] {
    let arr = (1...x).map { "\($0)" }.filter { $0.contains("\(d)") }.compactMap { Int64($0) }
    return [Int64(arr.count), Int64(arr.reduce(0, +)), Int64(arr.isEmpty ? 0 : arr.reduce(1, *))]
}


func searchAddMultiply(lastNum: Int, wantedNum: Int) -> [Int] {

    let wantedString = String(wantedNum)
    var count = 0
    var mult: Int?
    var add = 0
    for num in (1...lastNum) {
        if String(num).contains(wantedString) {
            count += 1
            mult = (mult ?? 1) * num
            add += num
        }
    }
    
    return [count, (mult ?? 0), add]

}


let date = Date()
searchAddMultiply(lastNum: 11, wantedNum: 1)
let time = Date().timeIntervalSince(date)


protocol Add {
    static func +(lhs: Self, rhs: Self) -> Self
}

func myAdd<T: Numeric>(_ a: T,_ b: T) -> T {
    return a + b
}

func myAdd<T: Add>(_ a: T, _ b: T) -> T {
    return a + b
}

extension String: Add {}

myAdd(2.0, 3.0)
myAdd("This", " That")



