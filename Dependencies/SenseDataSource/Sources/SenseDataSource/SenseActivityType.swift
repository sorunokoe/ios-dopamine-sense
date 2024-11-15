//
//  SenseActivityType.swift
//  SenseDataSource
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import Foundation

public enum SenseActivityType: CaseIterable, Sendable {
    case coffee
    case smoking

    public var title: String {
        switch self {
        case .coffee: return "Coffee"
        case .smoking: return "Smoking"
        }
    }
    
    public var icon: String {
        switch self {
        case .coffee:
            return "mug.fill"
        case .smoking:
            return "smoke"
        }
    }

    var dopamineBoostPercentage: Decimal {
        switch self {
        case .coffee: return 15
        case .smoking: return 55
        }
    }

    var dopamineDeficit: Decimal {
        switch self {
        case .coffee: return -10
        case .smoking: return -20
        }
    }

    var peakDopamineHour: Int {
        switch self {
        case .coffee, .smoking:
            return 1
        }
    }

    var longevityInHour: Int {
        switch self {
        case .coffee, .smoking:
            return 2
        }
    }

    var recoveryTimeInHour: Int {
        switch self {
        case .coffee:
            return 4
        case .smoking:
            return 6
        }
    }
}
