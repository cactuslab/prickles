//
//  XCUIApplicationExtensions.swift
//  Pods
//
//  Created by Thomas Carey on 28/06/17.
//  Copyright © 2017 Cactuslab. All rights reserved.
//

import XCTest

public extension XCUIApplication {
    
    public func reloadData() {
        /* Asking for the count of a query is a magical way to refresh the accessibilty data */
        _ = self.buttons.count
    }
    
}


