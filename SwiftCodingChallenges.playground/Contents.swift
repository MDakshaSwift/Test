import Foundation

//MARK: - Challenge One

/*
 Write a function that accepts a String as its only parameter, and returns true if the string has only unique letters,
 taking letter case into account
 */

func challengeOne(_ words: String) -> Bool {
    let tempWords = [Character](words.sorted())
    return tempWords == Set<Character>(words).sorted()
}

//Textbook Answer: Faster by 430%
func challengeOneSolution(_ input: String) -> Bool {
    return Set(input).count == input.count
}

//MARK: - Challenge Two

/*
 Is a string a palindrome
 */

func challengeTwo(_ words: String) -> Bool {
    return String(words.lowercased().reversed()) == words.lowercased()
}

//Textbook Answer: Slower by 90%
func challengeTwoSolution(_ input: String) -> Bool {
    let lowercased = input.lowercased()
    return String(lowercased.reversed()) == lowercased
}

//MARK: - Challenge Three

/*
 Write a function that accepts two String parameters, and returns true if they contain the same
 characters in any order taking into account letter case.
 */

func challengeThree(_ input1: String,_ input2: String) -> Bool {
    return [Character](input1).sorted() == [Character](input2).sorted()
}

//Textbook Answer: Practically the same speed!
func challengeThreeSolution(_ string1: String,_ string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}

//MARK: - Challenge Four

/*
 Write your own version of contains() method on String that ignores letter case, and
 without using the existing contains() method
 */


extension String {
    
    func fuzzyContains1(_ wordOfInterest: String) -> Bool {
        if let _ = self.lowercased().range(of: wordOfInterest.lowercased()) {
            return true
        }
        return false
    }
    
}

//Textbook Solution is better when traversing through larger strings!

extension String {
    
    func fuzzyContains2(_ string: String) -> Bool {
        return range(of: string, options: .caseInsensitive) != nil
    }
}

//MARK: - Challenge Five

/*
 Write a function that accepts a string, and returns how many times a specific character appears,
 taking case into account
 */

func appears(_ string: String, _ character: Character) -> Int {
    var count = 0
    string.forEach {
        if $0 == character {
            count += 1
        }
    }
    return count
}

//MARK: - Challenge Six

/*
 Write a function that accepts a string as its input, and returns the same string just
 with duplicate letters removed
 */

func noDuplicates(_ string: String) -> String {
    var uniqueString = [Character]()
    string.forEach {
        if !uniqueString.contains($0) {
            uniqueString.append($0)
        }
    }
    return String(uniqueString)
}


//MARK: - Challenge Seven

/*
 Write a function that returns a string with any consecutive spaces replaced with a single space.
 */

func makeSingleSpace(_ string: String) -> String {
    return string.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
}


//MARK: - Challenge Eight

/*
 Write a function that accepts two strings, and returns true if one string is
 a rotation of the other, taking letter case into account
 */

func isRotated(_ string: String, _ candidate: String) -> Bool {
    let tempString = string + string
    return tempString.contains(candidate) && string.count == candidate.count
}

//MARK: - Challenge Nine

/*
 Write a function that returns true if it is given a string that is an English pangram,
 ignoring letter case.
 */

func isPangram(_ string: String) -> Bool {
    let set = Set<Character>(string.lowercased())
    let filteredSet = set.filter {
        $0 >= "a" && $0 <= "z"
    }
    return filteredSet.count == 26
}

//MARK: - Challenge Ten

/*
 Given a string in English, return a tuple containing the number of vowel and consonants
 */

func getVowelsAndConsonants(_ string: String) -> (Int, Int) {
    var tracker = (0,0)
    string.lowercased().forEach {
        let vowels = "aeiou"
        if vowels.contains($0) {
            tracker.0 += 1
        } else if $0 >= "a" && $0 <= "z" {
            tracker.1 += 1
        }
    }
    return tracker
}

//MARK: - Challenge Eleven

/*
 Write a function that accepts two strings, and returns true if they are identical in length
 but have no more than three different letters, taking case and string order into account
 */

func twoStringDeviated(_ string1: String, _ string2: String) -> Bool {
    var chr2 = [Character](string2)
    var returnVal = true
    var deviations = 0
    
    guard string1.count == string2.count else
    {
        return false
    }
    
    string1.forEach {
        if $0 != chr2[0] && chr2.count != 0 {
            deviations += 1
        }
        if deviations > 3 {
            returnVal = false
        }
        chr2.removeFirst()
    }
    
    return returnVal
}

//MARK: - Challenge Twelve

/*
 Write a function that accepts a string of words with a similar prefix, separated by spaces, and
 returns the longest substring that prefixes all words
 */

func prefixForWords(_ string: String) -> String {
    let words = string.components(separatedBy: " ")
    var prefix = words[0]
    
    for word in words {
        while !word.hasPrefix(prefix) {
            prefix.removeLast()
        }
    }
    
    return prefix
}

//MARK: - Challenge Thirteen

/*
 Write a function that accepts a string as input, then returns how often each letter is
 repeated in a single run, taking case into account.
 */

func runLengthEncoding(_ string: String) -> String {
    var completeString = ""
    var currentChar: Character?
    var charCounter = 0
    for letter in string {
        if letter == currentChar {
            charCounter += 1
        } else {
            if let char = currentChar {
                completeString.append("\(char)\(charCounter)")
            }
            currentChar = letter
            charCounter = 1
        }
    }
    if let current = currentChar {
        completeString.append("\(current)\(charCounter)")
    }
    return completeString
}

//MARK: - Challenge Fourteen

/*
 Write a function that prints all possible permutations of a given input string
 */

func permuteString(_ string: String) {
    var strArray = Array(string)
    var strCount = string.count - 1
    
    func permute(array: inout Array<Character>, count: Int) {
        if count <= 0 {
            print(String(array))
        } else {
            permute(array: &array, count: count - 1)
            for i in 0 ..< count {
                array.swapAt(i, count)
                permute(array: &array, count: count - 1)
                array.swapAt(i, count)
            }
        }
    }
    permute(array: &strArray, count: strCount)
}

//MARK: - Challenge Fifteen

/*
 Write a function that returns a string with each of its words reversed but in the
 original order, without using a loop
 */

func reverseWords(_ string: String) -> String {
    let arrayWords = string.components(separatedBy: " ")
    return arrayWords.map {
        String($0.reversed())
    }.joined(separator: " ")
    
}



//MARK: - Challenge Sixteen

/*
 Write a function that counts from 1 through 100, and prints "Fizz" if the counter is evenly
 divisible by 3, "Buzz" if it's evenly divisible by 5, "Fizz Buzz" if divisible by both
 and the number for all others
 */

func fizzBuzz() {
    for i in 1...100 {
        if i % 15 == 0 {
            print("Fizz Buzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print("\(i)")
        }
    }
}

//MARK: - Challenge Seventeen

/*
 Write a function that accepts a positive minimum and a maximum integer, and
 returns a random number between those two bounds, inclusive
 */

func inclusiveRand(_ min: Int, _ max: Int) -> Int {
    return Int.random(in: min...max)
}

//MARK: - Challenge Eighteen

/*
 Recreate the pow() that accepts two positive integers
 */

func powPow(_ base: Int, _ expo: Int) -> Int {
    var temp = base
    for _ in 2...expo {
        temp *= base
    }
    return temp
}

//MARK: - Challenge Ninteen

/*
 Swap two integers without using a temporary variable
 */

func swap1(_ a: inout Int, _ b: inout Int) {
    a =  a ^ b
    b =  a ^ b
    a =  a ^ b
}


//MARK: - Challenge Twenty

/*
 Write a function that accepts an integer as its parameter and returns true
 if the number is prime
 */

func isPrime(_ numb: Int) -> Bool {
    guard numb >= 2 else { return false }
    for i in 2...Int(ceil(sqrt(Double(numb)))) {
        if numb % i == 0 {
            return false
        }
    }
    return true
}

//MARK: - Challenge Twenty One

/*
 Create a function that accepts any positive integer and returns the next highest and next lowest
 number that has the same number of ones in its binary representation. If either number is not
 possible, return nil for it
 */



let date = Date()
let date1 = Date().timeIntervalSince(date)
