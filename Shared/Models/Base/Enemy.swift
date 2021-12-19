//
//  Enemy.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//


import Foundation
import CoreData

extension Enemy: NSManagedCodableObject {
	// MARK: - Enemy

	enum CodingKeys: String, CodingKey {
		case id, order, wave, monster
		case com2UsID = "com2us_id"
		case boss, stars, level, hp, attack, defense, speed, resist
		case accuracyBonus = "accuracy_bonus"
		case critBonus = "crit_bonus"
		case critDamageReduction = "crit_damage_reduction"
	}
//	struct EnemyData: Codable {
//		let id, order, wave, monster: Int
//		let com2UsID: Int
//		let boss: Bool
//		let stars, level, hp, attack: Int
//		let defense, speed, resist, accuracyBonus: Int
//		let critBonus, critDamageReduction: Int
//	}

}
