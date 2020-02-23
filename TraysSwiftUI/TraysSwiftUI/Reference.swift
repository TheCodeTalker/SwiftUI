//
//  Reference.swift
//  TraysSwiftUI
//
//  Created by Abhishek Chandrashekar on 09/02/20.
//  Copyright © 2020 Abhishek Chandrashekar. All rights reserved.
//

import Foundation

//mocking lazy initializers
//struct Structure {
//    // Deferred property initialization with lazy keyword
//    lazy var deferred = …
//
//    // Equivalent behavior without lazy keyword
//    private var _deferred: Type?
//    var deferred: Type {
//        get {
//            if let value = _deferred { return value }
//            let initialValue = …
//            _deferred = initialValue
//            return initialValue
//        }
//
//        set {
//            _deferred = newValue
//        }
//    }
//}

//potential use cases for the new @propertyWrapper attribute:
//
//Constraining Values
//Transforming Values on Property Assignment
//Changing Synthesized Equality and Comparison Semantics
//Auditing Property Access

//@Lazy, @Atomic, @ThreadSpecific, @Box, @Constrained


// Constarining Value


//@propertyWrapper attribute), it automatically “clamps” out-of-bound values within the prescribed range.
//@propertyWrapper
//struct Clamping<Value: Comparable> {
//    var value: Value
//    let range: ClosedRange<Value>
//
//    init(initialValue value: Value, _ range: ClosedRange<Value>) {
//        precondition(range.contains(value))
//        self.value = value
//        self.range = range
//    }
//
//    var wrappedValue: Value {
//        get { value }
//        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
//    }
//}

//struct Solution {
//    @Clamping(0...14) var pH: Double = 7.0
//}
//
//let carbonicAcid = Solution(pH: 4.68) // at 1 mM under standard conditions
//Attempting to set pH values outside that range results in the closest boundary value (minimum or maximum) to be used instead.
//
//let superDuperAcid = Solution(pH: -1)
//superDuperAcid.pH // 0
//You can use property wrappers in implementations of other property wrappers. For example, this UnitInterval property wrapper delegates to @Clamping for constraining values between 0 and 1, inclusive.
//@propertyWrapper
//struct UnitInterval<Value: FloatingPoint> {
//    @Clamping(0...1)
//    var wrappedValue: Value = .zero
//
//    init(initialValue value: Value) {
//        self.wrappedValue = value
//    }
//}
//For example, you might use the @UnitInterval property wrapper to define an RGB type that expresses red, green, blue intensities as percentages.
//struct RGB {
//    @UnitInterval var red: Double
//    @UnitInterval var green: Double
//    @UnitInterval var blue: Double
//}
//
//let cornflowerBlue = RGB(red: 0.392, green: 0.584, blue: 0.929)
//A @Positive / @NonNegative property wrapper that provides the unsigned guarantees to signed integer types.
//A @NonZero property wrapper that ensures that a number value is either greater than or less than 0.
//@Validated or @Whitelisted / @Blacklisted property wrappers that restrict which values can be assigned.


//Transforming Values


//@propertyWrapper
//struct Trimmed {
//    private(set) var value: String = ""
//
//    var wrappedValue: String {
//        get { value }
//        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
//    }
//
//    init(initialValue: String) {
//        self.wrappedValue = initialValue
//    }
//}


//Changing Synthesized Equality and Comparison Semantics



//@propertyWrapper
//struct CaseInsensitive<Value: StringProtocol> {
//    var wrappedValue: Value
//}
//
//extension CaseInsensitive: Comparable {
//    private func compare(_ other: CaseInsensitive) -> ComparisonResult {
//        wrappedValue.caseInsensitiveCompare(other.wrappedValue)
//    }
//
//    static func == (lhs: CaseInsensitive, rhs: CaseInsensitive) -> Bool {
//        lhs.compare(rhs) == .orderedSame
//    }
//
//    static func < (lhs: CaseInsensitive, rhs: CaseInsensitive) -> Bool {
//        lhs.compare(rhs) == .orderedAscending
//    }
//
//    static func > (lhs: CaseInsensitive, rhs: CaseInsensitive) -> Bool {
//        lhs.compare(rhs) == .orderedDescending
//    }
//}
//Although the greater-than operator (>) can be derived automatically, we implement it here as a performance optimization to avoid unnecessary calls to the underlying caseInsensitiveCompare method.
//Construct two string values that differ only by case, and they’ll return false for a standard equality check, but true when wrapped in a CaseInsensitive object.
//
//let hello: String = "hello"
//let HELLO: String = "HELLO"
//
//hello == HELLO // false
//CaseInsensitive(wrappedValue: hello) == CaseInsensitive(wrappedValue: HELLO) // true



//Auditing Property Access



//@propertyWrapper
//struct Versioned<Value> {
//    private var value: Value
//    private(set) var timestampedValues: [(Date, Value)] = []
//
//    var wrappedValue: Value {
//        get { value }
//
//        set {
//            defer { timestampedValues.append((Date(), value)) }
//            value = newValue
//        }
//    }
//
//    init(initialValue value: Value) {
//        self.wrappedValue = value
//    }
//}
//class ExpenseReport {
//    @Versioned var state: State = .submitted {
//        willSet {
//            if newValue == .approved,
//                $state.timestampedValues.map { $0.1 }.contains(.denied)
//            {
//                fatalError("J'Accuse!")
//            }
//        }
//    }
//}
//
//var tripExpenses = ExpenseReport()
//tripExpenses.state = .denied
//tripExpenses.state = .approved // Fatal error: "J'Accuse!"


//Limitations of property wrapper
