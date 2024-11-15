//
//  DopamineModel.swift
//  DopamineTracker
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import SwiftUI
import SenseDataSource
import SenseUI

public final class DopamineModel<DataSource: DataSourceProtocol>: ObservableObject {
    
    typealias ActivityType = DataSource.ActivityType
    typealias Data = DataSource.Data
    
    var dataSource: DataSource
    
    @Published var dataPoints: [Data] = []
    
    public init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func log(activity: ActivityType) {
        dataSource.log(activity: activity)
        dataPoints = dataSource.timeline()
    }
    
}
