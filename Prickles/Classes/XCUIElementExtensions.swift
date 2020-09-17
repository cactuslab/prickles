//
//  XCUIElementExtensions.swift
//  Pods
//
//  Created by Thomas Carey on 20/01/17.
//  Copyright © 2017 Cactuslab. All rights reserved.
//

import XCTest

public extension XCUIElement {
    
    func pr_scrollTo(element: XCUIElement, limit: Int = 30) {
        var count = 0
        while !element.pr_isVisible {
            swipeUp()
            count += 1
            if count == limit {
                return
            }
        }
    }
    
    var pr_isVisible: Bool {
        let app = XCUIApplication()
        let window = app.windows.element(boundBy: 0)
        let _ = window.frame.contains(CGRect(x: 1, y: 1, width: 1, height: 1)) // Force the UI cache to reload
        
        if self.exists && !self.frame.isEmpty {
            return window.frame.contains(self.frame)
        }
        return false
    }
    
}
