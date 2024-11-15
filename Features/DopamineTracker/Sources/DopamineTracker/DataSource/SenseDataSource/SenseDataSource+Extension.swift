//
//  File.swift
//  DopamineTracker
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import SenseDataSource
import SenseUI

extension SenseDataSource: DataSourceProtocol {
    public typealias ActivityType = SenseActivityType
    public typealias Data = SenseDopamineData
}

extension DopamineModel where DataSource == SenseDataSource {
    func map(timeline: [SenseDopamineData]) -> [DataPoint] {
        timeline.map {
            DataPoint(label: $0.types.map{ $0.title }.joined(separator: ", "), value: $0.value, dateTime: $0.date)
        }
    }
}
