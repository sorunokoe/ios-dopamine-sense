//
//  File.swift
//  DopamineTracker
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import Foundation

public protocol DataSourceProtocol {
    associatedtype ActivityType
    associatedtype Data
    
    func log(activity: ActivityType)
    func timeline() -> [Data]
}
