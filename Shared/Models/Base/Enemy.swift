//
//  Enemy.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/19/21.
//


import Foundation
import CoreData

@objc(Enemy)
public class Enemy: NSManagedObject, Decodable {
//extension Enemy: Decodable {
	// MARK: - Enemy

	enum CodingKeys: String, CodingKey {
		case id, order, wave, monster
		case com2usId = "com2us_id"
		case boss, stars, level, hp, attack, defense, speed, resist
		case accuracyBonus = "accuracy_bonus"
		case critBonus = "crit_bonus"
		case critDamageReduction = "crit_damage_reduction"
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "GameItem", in: context) else { fatalError("Could not get entity [for GameItem]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.com2usId = try container.decode(Int64.self, forKey: .com2usId)

		self.order = try container.decode(Int16.self, forKey: .order)
		self.wave = try container.decode(Int16.self, forKey: .wave)
		self.monster = try container.decode(Int16.self, forKey: .monster)
		self.boss = try container.decode(Bool.self, forKey: .boss)
		self.stars = try container.decode(Int16.self, forKey: .stars)
		self.level = try container.decode(Int16.self, forKey: .level)

		self.hp = try container.decode(Int64.self, forKey: .hp)
		self.attack = try container.decode(Int64.self, forKey: .attack)
		self.defense = try container.decode(Int64.self, forKey: .defense)
		self.speed = try container.decode(Int16.self, forKey: .speed)
		self.resist = try container.decode(Int16.self, forKey: .resist)

		self.accuracyBonus = try container.decode(Int16.self, forKey: .accuracyBonus)
		self.critBonus = try container.decode(Int16.self, forKey: .critBonus)
		self.critDamageReduction = try container.decode(Int16.self, forKey: .critDamageReduction)

	}


}
