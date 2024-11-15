//
//  PerformanceUITests.swift
//  PerformanceUITests
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import XCTest
@testable import DopamineInfo

final class PerformanceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric(waitUntilResponsive: false)]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testLaunchPerformanceUntilResponsive() throws {
        measure(metrics: [XCTApplicationLaunchMetric(waitUntilResponsive: true)]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testMemoryPerformance() throws {
        measure(metrics: [XCTMemoryMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testCPUPerformance() throws {
        measure(metrics: [XCTCPUMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testStoragePerformance() throws {
        measure(metrics: [XCTStorageMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testTimePerformance() throws {
        measure(metrics: [XCTClockMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testScrollPerformance() {
        let app = XCUIApplication()
        app.launch()

        let measureOptions = XCTMeasureOptions()
        measureOptions.invocationOptions = [.manuallyStop]

        measure(
            metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric],
            options: measureOptions
        ) {
            app.swipeUp(velocity: .fast)
            stopMeasuring()
            app.swipeDown(velocity: .fast)
        }
    }
}
