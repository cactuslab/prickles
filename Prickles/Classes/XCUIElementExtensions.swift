//
//  XCUIElementExtensions.swift
//  Pods
//
//  Created by Thomas Carey on 20/01/17.
//  Copyright © 2017 Cactuslab. All rights reserved.
//

import XCTest

public extension XCUIElement {
    
    public func scrollTo(element: XCUIElement) {
        while !element.isVisible {
            swipeUp()
        }
    }
    
    public var isVisible: Bool {
        let app = XCUIApplication()
        let window = app.windows.element(boundBy: 0)
        let _ = window.frame.contains(CGPoint(x: 1, y: 1)) // Force the UI cache to reload
        
        if self.exists && !self.frame.isEmpty {
            return window.frame.contains(self.frame)
        }
        return false
    }
    
}
