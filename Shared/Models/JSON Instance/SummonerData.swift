//
//  SummonerI.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/26/20.
//

import Foundation
import CoreData

enum TimezoneServerMap: String, CaseIterable {
    case global = "America/Los_Angeles"
    case europe = "Europe/Berlin"
    case korea = "Asia/Seoul"
    case asia = "Asia/Shanghai"
    case japan
    case china
}

// MARK: - JSON

public struct SummonerData: JsonArrayMutable {
    
    static var items = [SummonerData]()

    private enum CodingKeys: String, CodingKey {
        case id = "wizard_id"
        case name = "wizard_name"
        case lastUpdate = "wizard_last_login"
        case server = "tzone"
        case timezone = "timezone"
    }

    let id:             Int64
    let name:           String
    let lastUpdate:     Date?
    let server:         String
    let timezone:       String

    public init(summoner: JSON, tzone: JSON) {
        id = summoner.wizard_id.int
        name = summoner.wizard_name.string

        let rawDate = summoner.wizard_last_login.string
        let formatter = DateFormatter.com2us
        lastUpdate = formatter.date(from: rawDate)
        
        let tz = tzone.string
        timezone = tz
        let serverMap = TimezoneServerMap.from(string: tz)
        server = serverMap?.toString() ?? ""
    }
    
    static func saveToCoreData(_ docInfo: inout SummonerDocumentInfo) {
        
        Summoner.batchUpdate(from: SummonerData.items,
                             docInfo: &docInfo)
        do {
            if docInfo.taskContext.hasChanges {
                try docInfo.taskContext.save()
            }
            
        } catch {
            print("could not save context")
        }
    }
}
