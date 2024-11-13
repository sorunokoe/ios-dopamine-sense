//
//  DopamineSenseUITestsLaunchTests.swift
//  DopamineSenseUITests
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import XCTest

final class DopamineSenseUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
