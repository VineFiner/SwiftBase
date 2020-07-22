//
//  Fibonacci.swift
//  Fibonacci
//
//  Created by vine on 2019/6/24.
//

import Foundation

class Fibonacci {
    func test() {
        
         struct Countdown: Sequence {
             let start: Int

             func makeIterator() -> CountdownIterator {
                 return CountdownIterator(self)
             }
         }
    ///
    /// The `makeIterator()` method returns another custom type, an iterator named
    /// `CountdownIterator`. The `CountdownIterator` type keeps track of both the
    /// `Countdown` sequence that it's iterating and the number of times it has
    /// returned a value.
    ///
         struct CountdownIterator: IteratorProtocol {
             let countdown: Countdown
             var times = 0
    
             init(_ countdown: Countdown) {
                 self.countdown = countdown
             }
    
             mutating func next() -> Int? {
                 let nextNumber = countdown.start - times
                 guard nextNumber > 0
                     else { return nil }
    
                 times += 1
                 return nextNumber
             }
         }
    ///
    /// Each time the `next()` method is called on a `CountdownIterator` instance,
    /// it calculates the new next value, checks to see whether it has reached
    /// zero, and then returns either the number, or `nil` if the iterator is
    /// finished returning elements of the sequence.
    ///
    /// Creating and iterating over a `Countdown` sequence uses a
    /// `CountdownIterator` to handle the iteration.
    ///
     let threeTwoOne = Countdown(start: 3)
         for count in threeTwoOne {
             print("\(count)...")
         }
         // Prints "3..."
         // Prints "2..."
         // Prints "1..."
    }
}
//struct Countdown: Sequence, IteratorProtocol {
//    var count: Int
//    
//    mutating func next() -> Int? {
//        if count == 0 {
//            return nil
//        } else {
//            defer { count -= 1 }
//            return count
//        }
//    }
//}
