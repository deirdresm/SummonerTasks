//
//  SkillData.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/15/20.
//

import Foundation
import CoreData

// MARK: - JSON - SkillData

public struct SkillData: JsonArray {

	static var items = [SkillData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case com2usId = "com2us_id"
		case name
		case c2uDescription = "description"
		case slot
		case cooltime
		case hits
		case aoe
		case passive
		case maxLevel
		case imageFilename
		case multiplierFormula
		case multiplierFormulaRaw
		case levelProgressDescription
		case skillEffect
		case scalingStats
	}

	let id:             Int64
	let com2usId:       Int64
	let name:           String
	let c2uDescription: String
	let slot:           Int64
	let cooltime:       Int64?
	let hits:           Int64
	let aoe:            Bool
	let passive:        Bool
	let maxLevel:       Int64
	let imageFilename:  String
	let multiplierFormula:         String
	let multiplierFormulaRaw:      [String]
	let levelProgressDescription:  String
	let skillEffect:     [Int64]
	let scalingStats:    [Int64]

	public init(skill: JSON, pk: Int64) {
		id = skill.pk.int
		com2usId = skill.fields.com2us_id.int
		name = skill.fields.name.string
		c2uDescription = skill.fields.description.string
		slot = skill.fields.slot.int
		cooltime = skill.fields.cooltime.int
		hits = skill.fields.hits.int
		aoe = skill.fields.aoe.bool
		passive = skill.fields.passive.bool
		maxLevel = skill.fields.max_level.int
		imageFilename = skill.fields.icon_filename.string
		multiplierFormula = skill.fields.multiplier_formula.string
		levelProgressDescription = skill.fields.level_progress_description.string

		// FIXME: this isn't importing correctly.
		var jsonArr = skill.fields.multiplier_formula_raw.array
		multiplierFormulaRaw =  jsonArr.map { $0.string}

		jsonArr = skill.fields.skill_effect.array
		skillEffect = jsonArr.map { $0.int}

		jsonArr = skill.fields.scaling_stats.array
		scalingStats = jsonArr.map { $0.int}

	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			Skill.batchUpdate(from: SkillData.items,
							  docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}

			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - LeaderSkillData

//{
//"model": "bestiary.leaderskill",
//"pk": 1,
//"fields": {
//  "attribute": 7,
//  "amount": 15,
//  "area": 1,
//  "element": null
//}
//},


public struct LeaderSkillData: JsonArray {

	static var items = [LeaderSkillData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case attribute
		case amount
		case area
		case element
	}

	let id:             Int64
	let attribute:      Int64?
	let amount:         Int64
	let area:           Int64
	let element:        String?

	public init(skill: JSON, pk: Int64) {
		id = skill.pk.int
		attribute = skill.fields.attribute.int
		amount = skill.fields.amount.int
		area = skill.fields.area.int
		element = skill.fields.element.string
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			LeaderSkill.batchUpdate(from: LeaderSkillData.items,
									docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - SkillUpgradeData

//{
//   "model": "bestiary.skillupgrade",
//   "pk": 8846,
//   "fields": {
//     "skill": 2983,
//     "level": 6,
//     "effect": 3,
//     "amount": 1
//   }
// },


public struct SkillUpgradeData: JsonArray {

	static var items = [SkillUpgradeData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skill
		case level
		case effect
		case amount
	}

	let id:             Int64
	let skill:          Int64
	let level:          Int64
	let effect:         Int64
	let amount:         Int64

	public init(skillUpgrade: JSON, pk: Int64) {
		id = skillUpgrade.pk.int
		skill = skillUpgrade.fields.skill.int
		level = skillUpgrade.fields.level.int
		effect = skillUpgrade.fields.effect.int
		amount = skillUpgrade.fields.amount.int
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			SkillUpgrade.batchUpdate(from: SkillUpgradeData.items,
									 docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - SkillEffectData

//{
//  "model": "bestiary.skilleffect",
//  "pk": 1,
//  "fields": {
//    "is_buff": true,
//    "name": "Increase ATK",
//    "description": "Attack Power is increased by 50%",
//    "icon_filename": "buff_attack_up.png"
//  }
//},

public struct SkillEffectData: JsonArray {

	static var items = [SkillEffectData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case isBuff = "is_buff"
		case name
		case c2uDescription = "description"
		case imageFilename = "icon_filename"
	}

	let id:             Int64
	let isBuff:         Bool
	let name:           String
	let c2uDescription: String
	let imageFilename:  String

	public init(skillEffect: JSON, pk: Int64) {
		id = skillEffect.pk.int
		isBuff = skillEffect.fields.is_buff.bool
		name = skillEffect.fields.name.string
		c2uDescription = skillEffect.fields.description.string
		imageFilename = skillEffect.fields.icon_filename.string
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			SkillEffect.batchUpdate(from: SkillEffectData.items,
									docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - SkillEffectDetailData

//{
//  "model": "bestiary.skilleffectdetail",
//  "pk": 1,
//  "fields": {
//    "skill": 639,
//    "effect": 19,
//    "aoe": false,
//    "single_target": true,
//    "self_effect": false,
//    "chance": 100,
//    "on_crit": false,
//    "on_death": false,
//    "random": false,
//    "quantity": 1,
//    "all": false,
//    "self_hp": false,
//    "target_hp": false,
//    "damage": false,
//    "note": null
//  }
//},

public struct SkillEffectDetailData: JsonArray {

	static var items = [SkillEffectDetailData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skill
		case effect
		case aoe
		case singleTarget = "single_target"
		case selfEffect = "self_effect"
		case chance
		case onCrit = "on_crit"
		case onDeath = "on_death"
		case random
		case quantity
		case all
		case selfHp = "self_hp"
		case targetHp = "target_hp"
		case damage
		case note
	}

	let id:             Int64
	let skill:          Int64
	let effect:         Int64
	let aoe:            Bool
	let singleTarget:   Bool
	let selfEffect:     Bool
	let chance:         Int64
	let onCrit:         Bool
	let onDeath:        Bool
	let random:         Bool
	let quantity:       Int64
	let all:            Bool
	let selfHp:         Bool
	let targetHp:       Bool
	let damage:         Bool
	let note:           String

	public init(skillEffectDetail: JSON, pk: Int64) {
		id = skillEffectDetail.pk.int
		skill = skillEffectDetail.fields.skill.int
		effect = skillEffectDetail.fields.effect.int
		aoe = skillEffectDetail.fields.aoe.bool
		singleTarget = skillEffectDetail.fields.single_target.bool
		selfEffect = skillEffectDetail.fields.self_effect.bool
		chance = skillEffectDetail.fields.chance.int
		onCrit = skillEffectDetail.fields.on_crit.bool
		onDeath = skillEffectDetail.fields.on_death.bool
		random = skillEffectDetail.fields.random.bool
		quantity = skillEffectDetail.fields.quantity.int
		all = skillEffectDetail.fields.all.bool
		selfHp = skillEffectDetail.fields.self_hp.bool
		targetHp = skillEffectDetail.fields.target_hp.bool
		damage = skillEffectDetail.fields.damage.bool
		note = skillEffectDetail.fields.note.string
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			SkillEffectDetail.batchUpdate(from: SkillEffectDetailData.items,
										  docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - SkillEffectDetailData

//{
//  "model": "bestiary.scalingstat",
//  "pk": 10,
//  "fields": {
//    "stat": "ATK",
//    "com2us_desc": "ATK",
//    "description": ""
//  }
//},

public struct ScalingStatData: JsonArray {

	static var items = [ScalingStatData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case stat
		case c2uDesc = "com2us_desc"
		case scalingDesc = "description"
	}

	let id:             Int64
	let stat:           String
	let c2uDesc:        String
	let scalingDesc:    String

	public init(scalingStat: JSON, pk: Int64) {
		id = scalingStat.pk.int
		stat = scalingStat.fields.stat.string
		c2uDesc = scalingStat.fields.com2us_desc.string
		scalingDesc = scalingStat.fields.description.string
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			ScalingStat.batchUpdate(from: ScalingStatData.items,
									docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}

// MARK: - JSON - HomunculusSkillData

//{
//   "model": "bestiary.homunculusskill",
//   "pk": 66,
//   "fields": {
//     "skill": 1735,
//     "monsters": [
//       1049,
//       1051
//     ],
//     "prerequisites": [
//       1730,
//       1731
//     ]
//   }
// },

public struct HomunculusSkillData: JsonArray {

	static var items = [HomunculusSkillData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case skill
		case monsters
		case prerequisites
	}

	let id:             Int64
	let skill:          Int64
	let monsters:       [Int64]
	let prerequisites:  [Int64]

	public init(homunculusSkill: JSON, pk: Int64) {
		id = homunculusSkill.pk.int
		skill = homunculusSkill.fields.skill.int

		var jsonArr = homunculusSkill.fields.monsters.array
		monsters =  jsonArr.map { $0.int}

		jsonArr = homunculusSkill.fields.prerequisites.array
		prerequisites = jsonArr.map { $0.int}
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			HomunculusSkill.batchUpdate(from: HomunculusSkillData.items,
										docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}

}

// MARK: - JSON - HomunculusSkillcraftData

//{
//   "model": "bestiary.homunculusskill",
//   "pk": 66,
//   "fields": {
//     "skill": 1735,
//     "monsters": [
//       1049,
//       1051
//     ],
//     "prerequisites": [
//       1730,
//       1731
//     ]
//   }
// },

/*   {
 "model": "bestiary.homunculusskillcraftcost",
 "pk": 5897,
 "fields": {
   "item": 6,
   "quantity": 50000,
   "skill": 1
 }
},

 */

public struct HomunculusSkillcraftData: JsonArray {

	static var items = [HomunculusSkillcraftData]()

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case item
		case quantity
		case skill
	}

	let id:             Int64
	let item:           Int64
	let quantity:       Int64
	let skill:          Int64

	public init(homunculusSkill: JSON, pk: Int64) {
		id = homunculusSkill.pk.int
		item = homunculusSkill.item.int
		quantity = homunculusSkill.quantity.int
		skill = homunculusSkill.fields.skill.int
	}

	static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {

		docInfo.taskContext.perform {
			HomunculusSkillcraftCost.batchUpdate(from: HomunculusSkillcraftData.items,
												 docInfo: docInfo)
			do {
				if docInfo.taskContext.hasChanges {
					try docInfo.taskContext.save()
				}
			} catch {
				print("could not save context")
			}
		}
	}
}


/*

 {
   "model": "bestiary.skill",
   "pk": 2969,
   "fields": {
	 "com2us_id": 110203,
	 "name": "Purification Device",
	 "description": "Attacks all enemies to weaken their Attack Power for 2 turns with a 50% chance and removes all harmful effects granted on the boss.",
	 "slot": 1,
	 "cooltime": null,
	 "hits": 1,
	 "aoe": false,
	 "passive": false,
	 "max_level": 1,
	 "icon_filename": "skill_icon_0021_3_4.png",
	 "multiplier_formula": "7.0*{ATK}",
	 "multiplier_formula_raw": "[[\"ATK\", \"*\", 7.0]]",
	 "level_progress_description": "",
	 "skill_effect": [

	 ],
	 "scaling_stats": [
	   10
	 ]
   }
 },
{
   "model": "bestiary.skillupgrade",
   "pk": 8846,
   "fields": {
	 "skill": 2983,
	 "level": 6,
	 "effect": 3,
	 "amount": 1
   }
 },
 {
 "model": "bestiary.leaderskill",
 "pk": 1,
 "fields": {
   "attribute": 7,
   "amount": 15,
   "area": 1,
   "element": null
 }
},
 {
   "model": "bestiary.leaderskill",
   "pk": 13,
   "fields": {
	 "attribute": 4,
	 "amount": 13,
	 "area": 1,
	 "element": null
   }
 },
 {
   "model": "bestiary.skilleffect",
   "pk": 1,
   "fields": {
	 "is_buff": true,
	 "name": "Increase ATK",
	 "description": "Attack Power is increased by 50%",
	 "icon_filename": "buff_attack_up.png"
   }
 },
 {
   "model": "bestiary.skilleffectdetail",
   "pk": 1,
   "fields": {
	 "skill": 639,
	 "effect": 19,
	 "aoe": false,
	 "single_target": true,
	 "self_effect": false,
	 "chance": 100,
	 "on_crit": false,
	 "on_death": false,
	 "random": false,
	 "quantity": 1,
	 "all": false,
	 "self_hp": false,
	 "target_hp": false,
	 "damage": false,
	 "note": null
   }
 },
 {
   "model": "bestiary.scalingstat",
   "pk": 10,
   "fields": {
	 "stat": "ATK",
	 "com2us_desc": "ATK",
	 "description": ""
   }
 },
 {
   "model": "bestiary.homunculusskill",
   "pk": 1,
   "fields": {
	 "skill": 1572,
	 "monsters": [
	   1011,
	   1006
	 ],
	 "prerequisites": [
	   1574
	 ]
   }
 },
 {
	"model": "bestiary.homunculusskill",
	"pk": 66,
	"fields": {
	  "skill": 1735,
	  "monsters": [
		1049,
		1051
	  ],
	  "prerequisites": [
		1730,
		1731
	  ]
	}
  },



 CREATE TABLE public.bestiary_leaderskill
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_leaderskill_id_seq'::regclass),
	 attribute integer NOT NULL,
	 amount integer NOT NULL,
	 area integer NOT NULL,
	 element character varying(6) COLLATE pg_catalog."default",
	 CONSTRAINT bestiary_leaderskill_pkey PRIMARY KEY (id)
 )


 // many-to-many join table
 CREATE TABLE public.bestiary_monster_skills
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_monster_skills_id_seq'::regclass),
	 monster_id integer NOT NULL,
	 skill_id integer NOT NULL,
	 CONSTRAINT bestiary_monster_skills_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_monster_skills_monster_id_skill_id_fccab7c9_uniq UNIQUE (monster_id, skill_id),
	 CONSTRAINT bestiary_monster_ski_monster_id_7bf71536_fk_bestiary_ FOREIGN KEY (monster_id)
		 REFERENCES public.bestiary_monster (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED,
	 CONSTRAINT bestiary_monster_skills_skill_id_3f62eb14_fk_bestiary_skill_id FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_skill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )

 CREATE TABLE public.bestiary_scalingstat
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_scalingstat_id_seq'::regclass),
	 stat character varying(20) COLLATE pg_catalog."default" NOT NULL,
	 com2us_desc character varying(30) COLLATE pg_catalog."default",
	 description text COLLATE pg_catalog."default",
	 CONSTRAINT bestiary_scalingstat_pkey PRIMARY KEY (id)
 )



 CREATE TABLE public.bestiary_skill
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_skill_id_seq'::regclass),
	 name character varying(60) COLLATE pg_catalog."default" NOT NULL,
	 com2us_id integer,
	 description text COLLATE pg_catalog."default" NOT NULL,
	 slot integer NOT NULL,
	 cooltime integer,
	 hits integer NOT NULL,
	 aoe boolean NOT NULL,
	 passive boolean NOT NULL,
	 max_level integer NOT NULL,
	 level_progress_description text COLLATE pg_catalog."default",
	 icon_filename character varying(100) COLLATE pg_catalog."default",
	 multiplier_formula text COLLATE pg_catalog."default",
	 multiplier_formula_raw character varying(150) COLLATE pg_catalog."default",
	 CONSTRAINT bestiary_skill_pkey PRIMARY KEY (id)
 )

 CREATE TABLE public.bestiary_skill_scaling_stats
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_skill_scaling_stats_id_seq'::regclass),
	 skill_id integer NOT NULL,
	 scalingstat_id integer NOT NULL,
	 CONSTRAINT bestiary_skill_scaling_stats_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_skill_scaling_s_skill_id_scalingstat_id_26c92422_uniq UNIQUE (skill_id, scalingstat_id),
	 CONSTRAINT bestiary_skill_scali_scalingstat_id_8218a512_fk_bestiary_ FOREIGN KEY (scalingstat_id)
		 REFERENCES public.bestiary_scalingstat (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED,
	 CONSTRAINT bestiary_skill_scali_skill_id_0cc73ebc_fk_bestiary_ FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_skill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )

 CREATE TABLE public.bestiary_skilleffect
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_skilleffect_id_seq'::regclass),
	 is_buff boolean NOT NULL,
	 name character varying(40) COLLATE pg_catalog."default" NOT NULL,
	 description text COLLATE pg_catalog."default" NOT NULL,
	 icon_filename character varying(100) COLLATE pg_catalog."default" NOT NULL,
	 CONSTRAINT bestiary_skilleffect_pkey PRIMARY KEY (id)
 )

 CREATE TABLE public.bestiary_skilleffectdetail
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_skilleffectdetail_id_seq'::regclass),
	 aoe boolean NOT NULL,
	 single_target boolean NOT NULL,
	 self_effect boolean NOT NULL,
	 chance integer,
	 on_crit boolean NOT NULL,
	 on_death boolean NOT NULL,
	 random boolean NOT NULL,
	 quantity integer,
	 "all" boolean NOT NULL,
	 self_hp boolean NOT NULL,
	 target_hp boolean NOT NULL,
	 damage boolean NOT NULL,
	 note text COLLATE pg_catalog."default",
	 effect_id integer NOT NULL,
	 skill_id integer NOT NULL,
	 CONSTRAINT bestiary_skilleffectdetail_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_skilleffect_effect_id_fc7dd1eb_fk_bestiary_ FOREIGN KEY (effect_id)
		 REFERENCES public.bestiary_skilleffect (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED,
	 CONSTRAINT bestiary_skilleffect_skill_id_a8ed5058_fk_bestiary_ FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_skill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )

 CREATE TABLE public.bestiary_skillupgrade
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_skillupgrade_id_seq'::regclass),
	 level integer NOT NULL,
	 effect integer NOT NULL,
	 amount integer NOT NULL,
	 skill_id integer NOT NULL,
	 CONSTRAINT bestiary_skillupgrade_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_skillupgrade_skill_id_1b1822ee_fk_bestiary_skill_id FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_skill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )

 CREATE TABLE public.bestiary_homunculusskill_prerequisites
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_homunculusskill_prerequisites_id_seq'::regclass),
	 homunculusskill_id integer NOT NULL,
	 skill_id integer NOT NULL,
	 CONSTRAINT bestiary_homunculusskill_prerequisites_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_homunculusskill_homunculusskill_id_skill_d8c42a7d_uniq UNIQUE (homunculusskill_id, skill_id),
	 CONSTRAINT bestiary_homunculuss_homunculusskill_id_1e829ede_fk_bestiary_ FOREIGN KEY (homunculusskill_id)
		 REFERENCES public.bestiary_homunculusskill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED,
	 CONSTRAINT bestiary_homunculuss_skill_id_830944ad_fk_bestiary_ FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_skill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )

 CREATE TABLE public.bestiary_homunculusskillcraftcost
 (
	 id integer NOT NULL DEFAULT nextval('bestiary_homunculusskillcraftcost_id_seq'::regclass),
	 quantity integer NOT NULL,
	 skill_id integer NOT NULL,
	 item_id integer NOT NULL,
	 CONSTRAINT bestiary_homunculusskillcraftcost_pkey PRIMARY KEY (id),
	 CONSTRAINT bestiary_homunculuss_item_id_5944c17f_fk_bestiary_ FOREIGN KEY (item_id)
		 REFERENCES public.bestiary_gameitem (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED,
	 CONSTRAINT bestiary_homunculuss_skill_id_e4892f69_fk_bestiary_ FOREIGN KEY (skill_id)
		 REFERENCES public.bestiary_homunculusskill (id) MATCH SIMPLE
		 ON UPDATE NO ACTION
		 ON DELETE NO ACTION
		 DEFERRABLE INITIALLY DEFERRED
 )





 */
