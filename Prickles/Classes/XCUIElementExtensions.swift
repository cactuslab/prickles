//
//  XCUIElementExtensions.swift
//  Pods
//
//  Created by Thomas Carey on 20/01/17.
//  Copyright © 2017 Cactuslab. All rights reserved.
//

import XCTest

extension XCUIElement {
    
    public func scrollTo(element: XCUIElement) {
        while !element.isVisible {
            swipeUp()
        }
    }
    
    public var isVisible: Bool {
        if self.exists && !self.frame.isEmpty {
            return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
        }
        return false
    }
    
}
