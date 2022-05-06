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
		case fields
	}

	public required convenience init(from decoder: Decoder) throws {
		// get the context and the entity in the context
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { fatalError("Could not get context [for GameItem]") }
		guard let entity = NSEntityDescription.entity(forEntityName: "Enemy", in: context) else { fatalError("Could not get entity [for Enemy]") }

		// init self
		self.init(entity: entity, insertInto: context)

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding

		let fields: [String: Any] = try container.decode([String: Any].self, forKey: .fields)
		// start decoding
		self.com2usId = (fields["com2usId"]).orInt
		self.order = (fields["order"]).orInt16
		self.waveid = (fields["wave"]).orInt16
		self.monsterId = (fields["com2usId"]).orInt

		self.boss = (fields["boss"]).orFalse
		self.stars = (fields["stars"]).orInt16
		self.levelid = (fields["level"]).orInt16

		self.hp = (fields["hp"]).orInt
		self.attack = (fields["attack"]).orInt
		self.defense = (fields["defense"]).orInt
		self.speed = (fields["speed"]).orInt16
		self.resist = (fields["resist"]).orInt16

		self.accuracyBonus = (fields["accuracy_bonus"]).orInt16
		self.critBonus = (fields["crit_bonus"]).orInt16
		self.critDamageReduction = (fields["crit_damage_reduction"]).orInt16

	}

	/// Wrapper around decodable initializer to add field that's wrapped weird.
	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}
}
