//
//  DopamineSenseTests.swift
//  DopamineSenseTests
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import Testing
import Foundation

import SenseUI
@testable import SenseDataSource
@testable import DopamineSense

struct DopamineSenseTests {

    @Test("Predicted timeline based on activities", arguments: SenseActivityType.allCases)
    func predictTimelineByLogging(activity: SenseActivityType) async throws {
        let model = DopamineModel(dataSource: SenseDataSource())
        model.log(activity: activity)
        let timeline = try #require(await model.dataPoints)
        let expectedTimeline = [
            DataPoint(label: activity.title, value: 0, dateTime: Date()),
            DataPoint(label: activity.title, value: activity.dopamineBoostPercentage, dateTime: Date.hour(after: activity.peakDopamineHour)),
            DataPoint(label: activity.title, value: 0, dateTime: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour)),
            DataPoint(label: activity.title, value: activity.dopamineDeficit, dateTime: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour)),
            DataPoint(label: activity.title, value: 0, dateTime: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour + 1)),
        ]
        #expect(timeline == expectedTimeline)
    }

}
