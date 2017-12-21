//
//  XCTestExtensions.swift
//  Prickles
//
//  Created by Thomas Carey on 16/01/17.
//
//

import XCTest

public extension XCTestCase {
    
    /** Wait for an element to be hittable, which is to say that it is onscreen and not being obscured.
     
     - Note: This does not mean that the element is enabled, it simply means that the user can touch it
     */
    public func waitForHittable(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "hittable == true", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    /** Wait for an element to **not** be hittable, which is to say that a user wouldn't be able to tap on it.
     
     - Note: This does not mean that the element is not enabled, it simply means that the user cannot touch it
     */
    public func waitForNotHittable(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "hittable == false", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    public func waitForExists(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "exists == true", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    public func waitForNotExists(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "exists == false", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    public func waitForEnabled(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "enabled == true", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    public func waitForNotEnabled(element: XCUIElement, waitSeconds: Double, file: String = #file, line: Int = #line) {
        waitForExpectation(element: element, expectation: "enabled == false", waitSeconds: waitSeconds, file: file, line: line)
    }
    
    /**
     Wait for an expectation to come true. The expectation is a string to be used in an NSPredicate. An example would be `"enabled == false"`.
     
     - Parameters:
     - element: The element
     - expectation: The expectation predicate string
     - waitSeconds: The amount of time to wait until record a failure
     - file: An optional filename used when a failure is recorded
     - line: An optional line number used when a failure is recorded
     */
    public func waitForExpectation(element: XCUIElement, expectation expectationPredicate: String, waitSeconds: Double, file: String = #file, line: Int = #line) {
        let predicate = NSPredicate(format: expectationPredicate)
        
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: waitSeconds) { (error) in
            if (error != nil) {
                let message = "Failed to find \(element) after \(waitSeconds) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
}
