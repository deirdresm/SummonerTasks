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

//   let wizardInfo = try WizardInfo(json)

import Foundation

// MARK: - WizardInfo
struct SummonerData: Codable {
    let wizardID: Int
    let wizardName: String
    let wizardMana, wizardCrystal, wizardCrystalPaid: Int
    let wizardLastLogin, wizardLastCountry, wizardLastLang: String
    let wizardLevel, experience, wizardEnergy, energyMax: Int
    let energyPerMin: Double
    let nextEnergyGain, arenaEnergy, arenaEnergyMax, arenaEnergyNextGain: Int
    let unitSlots: UnitSlots
    let repUnitID, repAssigned, pvpEvent, mailBoxEvent: Int
    let socialPointCurrent, socialPointMax, honorPoint, guildPoint: Int
    let darkportalEnergy, darkportalEnergyMax, costumePoint, costumePointMax: Int
    let honorMedal, honorMark, eventCoin, lobbyMasterID: Int
    let emblemMasterID, periodEnergyMax: Int

    enum CodingKeys: String, CodingKey {
        case wizardID = "wizard_id"
        case wizardName = "wizard_name"
        case wizardMana = "wizard_mana"
        case wizardCrystal = "wizard_crystal"
        case wizardCrystalPaid = "wizard_crystal_paid"
        case wizardLastLogin = "wizard_last_login"
        case wizardLastCountry = "wizard_last_country"
        case wizardLastLang = "wizard_last_lang"
        case wizardLevel = "wizard_level"
        case experience
        case wizardEnergy = "wizard_energy"
        case energyMax = "energy_max"
        case energyPerMin = "energy_per_min"
        case nextEnergyGain = "next_energy_gain"
        case arenaEnergy = "arena_energy"
        case arenaEnergyMax = "arena_energy_max"
        case arenaEnergyNextGain = "arena_energy_next_gain"
        case unitSlots = "unit_slots"
        case repUnitID = "rep_unit_id"
        case repAssigned = "rep_assigned"
        case pvpEvent = "pvp_event"
        case mailBoxEvent = "mail_box_event"
        case socialPointCurrent = "social_point_current"
        case socialPointMax = "social_point_max"
        case honorPoint = "honor_point"
        case guildPoint = "guild_point"
        case darkportalEnergy = "darkportal_energy"
        case darkportalEnergyMax = "darkportal_energy_max"
        case costumePoint = "costume_point"
        case costumePointMax = "costume_point_max"
        case honorMedal = "honor_medal"
        case honorMark = "honor_mark"
        case eventCoin = "event_coin"
        case lobbyMasterID = "lobby_master_id"
        case emblemMasterID = "emblem_master_id"
        case periodEnergyMax = "period_energy_max"
    }
}

// MARK: WizardInfo convenience initializers and mutators

extension SummonerData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SummonerData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        wizardID: Int? = nil,
        wizardName: String? = nil,
        wizardMana: Int? = nil,
        wizardCrystal: Int? = nil,
        wizardCrystalPaid: Int? = nil,
        wizardLastLogin: String? = nil,
        wizardLastCountry: String? = nil,
        wizardLastLang: String? = nil,
        wizardLevel: Int? = nil,
        experience: Int? = nil,
        wizardEnergy: Int? = nil,
        energyMax: Int? = nil,
        energyPerMin: Double? = nil,
        nextEnergyGain: Int? = nil,
        arenaEnergy: Int? = nil,
        arenaEnergyMax: Int? = nil,
        arenaEnergyNextGain: Int? = nil,
        unitSlots: UnitSlots? = nil,
        repUnitID: Int? = nil,
        repAssigned: Int? = nil,
        pvpEvent: Int? = nil,
        mailBoxEvent: Int? = nil,
        socialPointCurrent: Int? = nil,
        socialPointMax: Int? = nil,
        honorPoint: Int? = nil,
        guildPoint: Int? = nil,
        darkportalEnergy: Int? = nil,
        darkportalEnergyMax: Int? = nil,
        costumePoint: Int? = nil,
        costumePointMax: Int? = nil,
        honorMedal: Int? = nil,
        honorMark: Int? = nil,
        eventCoin: Int? = nil,
        lobbyMasterID: Int? = nil,
        emblemMasterID: Int? = nil,
        periodEnergyMax: Int? = nil
    ) -> SummonerData {
        return SummonerData(
            wizardID: wizardID ?? self.wizardID,
            wizardName: wizardName ?? self.wizardName,
            wizardMana: wizardMana ?? self.wizardMana,
            wizardCrystal: wizardCrystal ?? self.wizardCrystal,
            wizardCrystalPaid: wizardCrystalPaid ?? self.wizardCrystalPaid,
            wizardLastLogin: wizardLastLogin ?? self.wizardLastLogin,
            wizardLastCountry: wizardLastCountry ?? self.wizardLastCountry,
            wizardLastLang: wizardLastLang ?? self.wizardLastLang,
            wizardLevel: wizardLevel ?? self.wizardLevel,
            experience: experience ?? self.experience,
            wizardEnergy: wizardEnergy ?? self.wizardEnergy,
            energyMax: energyMax ?? self.energyMax,
            energyPerMin: energyPerMin ?? self.energyPerMin,
            nextEnergyGain: nextEnergyGain ?? self.nextEnergyGain,
            arenaEnergy: arenaEnergy ?? self.arenaEnergy,
            arenaEnergyMax: arenaEnergyMax ?? self.arenaEnergyMax,
            arenaEnergyNextGain: arenaEnergyNextGain ?? self.arenaEnergyNextGain,
            unitSlots: unitSlots ?? self.unitSlots,
            repUnitID: repUnitID ?? self.repUnitID,
            repAssigned: repAssigned ?? self.repAssigned,
            pvpEvent: pvpEvent ?? self.pvpEvent,
            mailBoxEvent: mailBoxEvent ?? self.mailBoxEvent,
            socialPointCurrent: socialPointCurrent ?? self.socialPointCurrent,
            socialPointMax: socialPointMax ?? self.socialPointMax,
            honorPoint: honorPoint ?? self.honorPoint,
            guildPoint: guildPoint ?? self.guildPoint,
            darkportalEnergy: darkportalEnergy ?? self.darkportalEnergy,
            darkportalEnergyMax: darkportalEnergyMax ?? self.darkportalEnergyMax,
            costumePoint: costumePoint ?? self.costumePoint,
            costumePointMax: costumePointMax ?? self.costumePointMax,
            honorMedal: honorMedal ?? self.honorMedal,
            honorMark: honorMark ?? self.honorMark,
            eventCoin: eventCoin ?? self.eventCoin,
            lobbyMasterID: lobbyMasterID ?? self.lobbyMasterID,
            emblemMasterID: emblemMasterID ?? self.emblemMasterID,
            periodEnergyMax: periodEnergyMax ?? self.periodEnergyMax
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UnitSlots
struct UnitSlots: Codable {
    let number: Int
}

// MARK: UnitSlots convenience initializers and mutators

extension UnitSlots {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UnitSlots.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        number: Int? = nil
    ) -> UnitSlots {
        return UnitSlots(
            number: number ?? self.number
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


//public struct SummonerData: JsonArrayMutable {
//
//    static var items = [SummonerData]()
//
//    private enum CodingKeys: String, CodingKey {
//        case id = "wizard_id"
//        case name = "wizard_name"
//        case lastUpdate = "wizard_last_login"
//        case server = "tzone"
//        case timezone = "timezone"
//    }
//
//    let id:             Int64
//    let name:           String
//    let lastUpdate:     Date?
//    let server:         String
//    let timezone:       String
//
//    public init(summoner: JSON, tzone: JSON) {
//        id = summoner.wizard_id.int
//        name = summoner.wizard_name.string
//
//        let rawDate = summoner.wizard_last_login.string
//        let formatter = DateFormatter.com2us
//        lastUpdate = formatter.date(from: rawDate)
//
//        let tz = tzone.string
//        timezone = tz
//        let serverMap = TimezoneServerMap.from(string: tz)
//        server = serverMap?.toString() ?? ""
//    }
//
//    static func saveToCoreData(_ docInfo: inout SummonerDocumentInfo) {
//
//        Summoner.batchUpdate(from: SummonerData.items,
//                             docInfo: &docInfo)
//        do {
//            if docInfo.taskContext.hasChanges {
//                try docInfo.taskContext.save()
//            }
//
//        } catch {
//            print("could not save context")
//        }
//    }
//}

