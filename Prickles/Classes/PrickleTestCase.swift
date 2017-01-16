//
//  PTestCase.swift
//  Prickles
//
//  Created by Tom Carey on 16/01/17.
//  Copyright © 2017 Cactuslab. All rights reserved.
//

import XCTest

public enum LaunchArguments: String {
    case cleanApplicationSupport = "CleanApplicationSupport"  /// This flag causes the ApplicationSupport folder (which contains all of the cached data files for a store) to be cleared upon launch
    case cleanUserDefaults = "CleanUserDefaults"  /// This flag clears the user defaults on launch (User defaults contain all sorts of information on which store is logged in and the current feature flags)
    case cleanKeychain = "CleanKeychain" /// This flag clears all keychain stored properties on launch.
    case uiTests = "UITests" /// This flag is to tell the running application that it is running in UITest mode
}

open class PrickleTestCase: XCTestCase {
    
    var launchEnvironment = [String: String]()
    var launchArguments = [String]()
    
    private static var testCaseSetup = Set<String>()
    
    override open func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let testCaseFirstRun = !PrickleTestCase.testCaseSetup.contains("\(type(of: self))")
        
        if testCaseFirstRun {
            setUpTestCase()
            PrickleTestCase.testCaseSetup.insert("\(type(of: self))")
        }
        
        setUpTest()
        
        setupLogin()
        
        if shouldResetApplicationForEachTest() {
            setupApplicationReset()
        }
        
        launchArguments.append(LaunchArguments.uiTests.rawValue)
        
        let application = XCUIApplication()
        
        application.launchEnvironment = launchEnvironment;
        application.launchArguments = launchArguments;
        application.launch()
        
        if testCaseFirstRun {
            beforeTestCase()
        }
        beforeTest()
    }
    
    override open func tearDown() {
        super.tearDown()
    }
    
    /** Configure the launch environment to contain all of the keys you need for authentication */
    open func setupLogin() {
    
    }
    
    /** Set up the test case. Called before the app is launched. You should call `super.setUpTestCase()` somewhere in your implementation */
    open func setUpTestCase() {
        if !shouldResetApplicationForEachTest() {
            setupApplicationReset()
        }
    }
    
    /** Set up the test. Called before the app is launched. */
    open func setUpTest() {
        
    }
    
    /** Called before the first test in a test case. Called after the app is launched. */
    open func beforeTestCase() {
        
    }
    
    /** Called before each test in a test case. Called after the app is launched. */
    open func beforeTest() {
        
    }
    
    /** Called after each test is run. */
    open func afterTest() {
        
    }
    
    /** Override this method to return `true` in test cases that require the application to be reset before each test. Defaults to `false` */
    open func shouldResetApplicationForEachTest() -> Bool {
        return false
    }
    
    private func setupApplicationReset() {
        launchArguments.append(LaunchArguments.cleanApplicationSupport.rawValue)
        launchArguments.append(LaunchArguments.cleanUserDefaults.rawValue)
        launchArguments.append(LaunchArguments.cleanKeychain.rawValue)
    }
    
}

