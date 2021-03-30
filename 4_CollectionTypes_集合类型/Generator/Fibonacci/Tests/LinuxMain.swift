import XCTest

import FibonacciTests

var tests = [XCTestCaseEntry]()
tests += FibonacciTests.allTests()
XCTMain(tests)
