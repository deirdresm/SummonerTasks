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

		// start decoding
		self.id = try decoder.decode("id")
		self.com2usId = try decoder.decode("com2usId")

		self.order = try decoder.decode("order")
		self.waveid = try decoder.decode("wave")
		self.monster = try decoder.decode("monster")
		self.boss = try decoder.decode("boss")
		self.stars = try decoder.decode("stars")
		self.levelid = try decoder.decode("level")

		self.hp = try decoder.decode("hp")
		self.attack = try decoder.decode("attack")
		self.defense = try decoder.decode("defense")
		self.speed = try decoder.decode("speed")
		self.resist = try decoder.decode("resist")

		self.accuracyBonus = try decoder.decode("accuracyBonus")
		self.critBonus = try decoder.decode("critBonus")
		self.critDamageReduction = try decoder.decode("critDamageReduction")

	}
}
