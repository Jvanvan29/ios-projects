import UIKit
import Foundation

var numbers: Array = [45, 73, 195, 53]
var computedNumber = numbers[0] * numbers[1] * numbers[2] * numbers[3]

let alphabet: Array<String> = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ]

var password: String = alphabet[Int.random(in: 0...25)] + alphabet[Int.random(in: 0...25)] + alphabet[Int.random(in: 0...25)] + alphabet[Int.random(in: 0...25)] + alphabet[Int.random(in: 0...25)] + alphabet[Int.random(in: 0...25)] 

print(password)
print("hello")
