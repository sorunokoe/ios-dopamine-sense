//
//  File.swift
//  SenseUI
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import Foundation

extension Date {
    func getHour() -> String {
        formatted(Date.FormatStyle().hour(.twoDigits(amPM: .abbreviated))) + ":" + formatted(Date.FormatStyle().minute(.twoDigits))
    }
}
