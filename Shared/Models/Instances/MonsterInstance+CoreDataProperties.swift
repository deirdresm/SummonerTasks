//
//  MonsterInstance+CoreDataProperties.swift
//  
//
//  Created by Deirdre Saoirse Moen on 1/24/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension MonsterInstance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonsterInstance> {
        return NSFetchRequest<MonsterInstance>(entityName: "MonsterInstance")
    }

    @NSManaged public var artifactAttack: Int64
    @NSManaged public var artifactDefense: Int64
    @NSManaged public var artifactHP: Int64
    @NSManaged public var avgRuneEfficiency: Float
    @NSManaged public var created: Date?
    @NSManaged public var customName: String?
    @NSManaged public var defaultBuildId: Int64
    @NSManaged public var fodder: Bool
    @NSManaged public var id: Int64
    @NSManaged public var ignoreForFusion: Bool
    @NSManaged public var inStorage: Bool
    @NSManaged public var level: Int64
    @NSManaged public var monsterId: Int64
    @NSManaged public var notes: String?
    @NSManaged public var ownerId: Int64
    @NSManaged public var priority: Int64
    @NSManaged public var rtaBuildId: Int64
    @NSManaged public var runeAccuracy: Int64
    @NSManaged public var runeAttack: Int64
    @NSManaged public var runeCritDamage: Int64
    @NSManaged public var runeCritRate: Int64
    @NSManaged public var runeDefense: Int64
    @NSManaged public var runeHp: Int64
    @NSManaged public var runeResistance: Int64
    @NSManaged public var runeSpeed: Int64
    @NSManaged public var skill1Level: Int64
    @NSManaged public var skill2Level: Int64
    @NSManaged public var skill3Level: Int64
    @NSManaged public var skill4Level: Int64
    @NSManaged public var stars: Int64
    @NSManaged public var artifacts: Set<ArtifactInstance>?
    @NSManaged public var monster: Monster?
    @NSManaged public var runes: NSSet?
    @NSManaged public var summoner: Summoner?
    @NSManaged public var teamLeaders: NSSet?
    @NSManaged public var teams: NSSet?

}

// MARK: Generated accessors for artifacts
extension MonsterInstance {

    @objc(addArtifactsObject:)
    @NSManaged public func addToArtifacts(_ value: ArtifactInstance)

    @objc(removeArtifactsObject:)
    @NSManaged public func removeFromArtifacts(_ value: ArtifactInstance)

    @objc(addArtifacts:)
    @NSManaged public func addToArtifacts(_ values: NSSet)

    @objc(removeArtifacts:)
    @NSManaged public func removeFromArtifacts(_ values: NSSet)

}

// MARK: Generated accessors for runes
extension MonsterInstance {

    @objc(addRunesObject:)
    @NSManaged public func addToRunes(_ value: RuneInstance)

    @objc(removeRunesObject:)
    @NSManaged public func removeFromRunes(_ value: RuneInstance)

    @objc(addRunes:)
    @NSManaged public func addToRunes(_ values: NSSet)

    @objc(removeRunes:)
    @NSManaged public func removeFromRunes(_ values: NSSet)

}

// MARK: Generated accessors for teamLeaders
extension MonsterInstance {

    @objc(addTeamLeadersObject:)
    @NSManaged public func addToTeamLeaders(_ value: Team)

    @objc(removeTeamLeadersObject:)
    @NSManaged public func removeFromTeamLeaders(_ value: Team)

    @objc(addTeamLeaders:)
    @NSManaged public func addToTeamLeaders(_ values: NSSet)

    @objc(removeTeamLeaders:)
    @NSManaged public func removeFromTeamLeaders(_ values: NSSet)

}

// MARK: Generated accessors for teams
extension MonsterInstance {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Team)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Team)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}

extension MonsterInstance : Identifiable {

}
