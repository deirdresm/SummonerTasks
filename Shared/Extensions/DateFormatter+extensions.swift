//
//  DateFormatter+extensions.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/4/20.
//

import Foundation

extension DateFormatter {
  static let com2us: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(identifier: "America/Los_Angeles") // where com2us's global server is
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
