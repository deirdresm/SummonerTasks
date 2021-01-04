//
//  SummonerI.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/20.
//

import Foundation
import CoreData

enum TimezoneServerMap: String {
    case global = "America/Los_Angeles"
    case europe = "Europe/Berlin"
    case korea = "Asia/Seoul"
    case asia = "Asia/Shanghai"
    case japan
    case china
}

// MARK: - JSON

public struct SummonerData {

    private enum CodingKeys: String, CodingKey {
        case id = "wizard_id"
        case name = "wizard_name"
        case lastUpdate = "wizard_last_login"
    }

    let id:             Int64
    let name:           String
    let lastUpdate:     Date?

    public init(summoner: JSON) {
        id = summoner.wizard_id.int
        name = summoner.fields.wizard_name.string

        let rawDate = summoner.fields.wizard_last_login.string
        let formatter = DateFormatter.com2us
        lastUpdate = formatter.date(from: rawDate)
    }
}
