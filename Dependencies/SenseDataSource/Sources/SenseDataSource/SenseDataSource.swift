import Foundation

public class SenseDopamineData: Equatable, CustomStringConvertible {
    public var types: [SenseActivityType]
    public var value: Decimal
    public var date: Date

    public init(types: [SenseActivityType], value: Decimal, date: Date) {
        self.types = types
        self.value = value
        self.date = date
    }

    public static func == (lhs: SenseDopamineData, rhs: SenseDopamineData) -> Bool {
        lhs.types == rhs.types && lhs.value == rhs.value && lhs.date.formatted(.dateTime) == rhs.date.formatted(.dateTime)
    }
    
    public var description: String {
        "Value: \(value) | Date: \(date.formatted(.dateTime)) | Types: \(types)"
    }
}

public final class SenseDataSource {
    private var timeToActivities: [Int: SenseDopamineData] = [:]
    private var activityTimeline: [SenseDopamineData] = []

    public init() {}

    public func log(activity: SenseActivityType) {
        // Log the inital level
        let now = Date()
        if timeToActivities[now.getHour()] == nil {
            let unit = SenseDopamineData(
                types: [activity],
                value: 0,
                date: now
            )
            activityTimeline.append(unit)
            timeToActivities[now.getHour()] = unit
        }

        // Log the boost phase
        let peakDateTime = Date.hour(after: activity.peakDopamineHour)
        if let data = timeToActivities[peakDateTime.getHour()] {
            let newDate = max(data.date, peakDateTime)
            timeToActivities[peakDateTime.getHour()]?.types.append(activity)
            timeToActivities[peakDateTime.getHour()]?.value += activity.dopamineBoostPercentage
            if newDate == data.date {
                timeToActivities[peakDateTime.getHour()]?.date = newDate
            } else {
                timeToActivities[newDate.getHour()] = timeToActivities[peakDateTime.getHour()] ?? data
                timeToActivities[peakDateTime.getHour()] = nil
            }
        } else {
            let unit = SenseDopamineData(
                types: [activity],
                value: activity.dopamineBoostPercentage,
                date: peakDateTime
            )
            activityTimeline.append(unit)
            timeToActivities[peakDateTime.getHour()] = unit
        }

        // Log the longevity phase
        let longetivityDateTime = Date.hour(after: activity.peakDopamineHour + activity.longevityInHour)
        if let data = timeToActivities[longetivityDateTime.getHour()] {
            let newDate = max(data.date, longetivityDateTime)
            timeToActivities[longetivityDateTime.getHour()]?.types.append(activity)
            timeToActivities[longetivityDateTime.getHour()]?.value = 0
            if newDate == data.date {
                timeToActivities[longetivityDateTime.getHour()]?.date = newDate
            } else {
                timeToActivities[newDate.getHour()] = timeToActivities[longetivityDateTime.getHour()] ?? data
                timeToActivities[longetivityDateTime.getHour()] = nil
            }
        } else {
            let unit = SenseDopamineData(
                types: [activity],
                value: 0,
                date: longetivityDateTime
            )
            activityTimeline.append(unit)
            timeToActivities[longetivityDateTime.getHour()] = unit
        }

        // Log the deficit phase
        let deficitDateTime = Date
            .hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour)
        if
            let data =
            timeToActivities[deficitDateTime.getHour()]
        {
            let newDate = max(data.date, deficitDateTime)
            timeToActivities[deficitDateTime.getHour()]?.types.append(activity)
            timeToActivities[deficitDateTime.getHour()]?.value += activity.dopamineDeficit
            if newDate == data.date {
                timeToActivities[deficitDateTime.getHour()]?.date = newDate
            } else {
                timeToActivities[newDate.getHour()] = timeToActivities[deficitDateTime.getHour()] ?? data
                timeToActivities[deficitDateTime.getHour()] = nil
            }
        } else {
            let unit = SenseDopamineData(
                types: [activity],
                value: activity.dopamineDeficit,
                date: deficitDateTime
            )
            activityTimeline.append(unit)
            timeToActivities[deficitDateTime.getHour()] = unit
        }

        // Log the recovery phase
        let recoveryDateTime = Date.hour(after: activity.peakDopamineHour + activity.longevityInHour + activity.recoveryTimeInHour + 1)
        if
            let data =
            timeToActivities[recoveryDateTime.getHour()]
        {
            let newDate = max(data.date, recoveryDateTime)
            timeToActivities[recoveryDateTime.getHour()]?.types.append(activity)
            timeToActivities[recoveryDateTime.getHour()]?.value = 0
            if newDate == data.date {
                timeToActivities[recoveryDateTime.getHour()]?.date = newDate
            } else {
                timeToActivities[newDate.getHour()] = timeToActivities[recoveryDateTime.getHour()] ?? data
                timeToActivities[recoveryDateTime.getHour()] = nil
            }
        } else {
            let unit = SenseDopamineData(
                types: [activity],
                value: 0,
                date: recoveryDateTime
            )
            activityTimeline.append(unit)
            timeToActivities[recoveryDateTime.getHour()] = unit
        }
    }

    public func timeline() -> [SenseDopamineData] {
        return activityTimeline
    }
}

extension Date {
    static func hour(after hour: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hour + 1, to: Date()) ?? Date()
    }

    func getHour() -> Int {
        Calendar.current.component(.hour, from: self)
    }
}
