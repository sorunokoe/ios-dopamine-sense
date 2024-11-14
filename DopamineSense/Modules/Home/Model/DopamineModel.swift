//
//  DopamineModel.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftUI
import SenseDataSource
import SenseUI

final class DopamineModel: ObservableObject {
    
    private var dataSource: SenseDataSource
    
    @Published var dataPoints: [DataPoint] = []
    
    init(dataSource: SenseDataSource) {
        self.dataSource = dataSource
    }
    
    func log(activity: SenseActivityType) {
        dataSource.log(activity: activity)
        dataPoints = dataSource.timeline().map {
            DataPoint(label: $0.types.map{ $0.title }.joined(separator: ", "), value: $0.value, dateTime: $0.date)
        }
    }
    
}
