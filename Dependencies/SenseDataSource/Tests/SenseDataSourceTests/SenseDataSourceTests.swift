import Foundation
@testable import SenseDataSource
import Testing

@Test("Predicted timeline based on activities", arguments: SenseActivityType.allCases)
func predictTimelineByLogging(activity: SenseActivityType) async throws {
    let dataSouce = SenseDataSource()
    dataSouce.log(activity: activity)
    let timeline = try #require(await dataSouce.timeline())
    let expectedTimeline = [
        SenseDopamineData(types: [activity], value: 0, date: Date()),
        SenseDopamineData(types: [activity], value: activity.dopamineBoostPercentage, date: Date.hour(after: activity.peakDopamineHour)),
        SenseDopamineData(types: [activity], value: 0, date: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour)),
        SenseDopamineData(
            types: [activity],
            value: activity.dopamineDeficit,
            date: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour)
        ),
        SenseDopamineData(
            types: [activity],
            value: 0,
            date: Date.hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour + 1)
        ),
    ]
    #expect(timeline == expectedTimeline)
}

@Test("Predicted timeline based on 2 activies in a row")
func predictTimelineWithTwoActivities() async throws {
    let dataSouce = SenseDataSource()
    let activities: [SenseActivityType] = [.coffee, .smoking]

    activities.forEach(dataSouce.log(activity:))
    let timeline = try #require(await dataSouce.timeline())
    
    let expectedTimeline = [
        SenseDopamineData(
            types: [.coffee],
            value: 0,
            date: Date()
        ),
        SenseDopamineData(
            types: [.coffee, .smoking],
            value: 70,
            date: Date.hour(after: 1)
        ),
        SenseDopamineData(
            types: [.coffee, .smoking],
            value: 0,
            date: Date.hour(after: 3)
        ),
        SenseDopamineData(
            types: [.coffee],
            value: -10,
            date: Date.hour(after: 7)
        ),
        SenseDopamineData(
            types: [.coffee],
            value: 0,
            date: Date.hour(after: 8)
        ),
        SenseDopamineData(
            types: [.smoking],
            value: -20,
            date: Date.hour(after: 9)
        ),
        SenseDopamineData(
            types: [.smoking],
            value: 0,
            date: Date.hour(after: 10)
        ),
    ]
    #expect(timeline == expectedTimeline)
}
