import Cocoa
import Foundation

class Summoner: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "wizard_id"
		case name = "wizard_name"
		case lastUpdate = "wizard_last_login"
	}

	var id: Int64
	var name: String

	init() {
		id = 1
		name = "Pluto"
	}

	// MARK: - Decodable
	required convenience public init(from decoder: Decoder) throws {

		self.init()

		// create container
		let container = try decoder.container(keyedBy: CodingKeys.self)
		// and start decoding
		self.id = try container.decode(Int64.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
	}
}

var summoner: Summoner

var json = """
{
	"command": "HubUserLogin",
	"ret_code": 0,
	"wizard_info": {
		"wizard_id": 29593827,
		"wizard_name": "deirdresm",
		"wizard_mana": 606256,
		"wizard_crystal": 95819,
		"wizard_crystal_paid": 95815,
		"wizard_last_login": "2022-03-06 15:02:15",
		"wizard_last_country": "US",
		"wizard_last_lang": "en",
		"wizard_level": 50,
		"experience": 3800000,
		"wizard_energy": 10136,
		"energy_max": 210,
		"energy_per_min": 0.26,
		"next_energy_gain": 0,
		"arena_energy": 10,
		"arena_energy_max": 10,
		"arena_energy_next_gain": 0,
		"unit_slots": {
			"number": 120
		},
	},
	"runes": [
		{
			"rune_id": 34125833908,
			"wizard_id": 29593827,
			"occupied_type": 1,
			"occupied_id": 16933876713,
			"slot_no": 1,
			"rank": 5,
			"class": 6,
			"set_id": 5,
			"upgrade_limit": 15,
			"upgrade_curr": 15,
			"base_value": 662530,
			"sell_value": 33126,
			"pri_eff": [
				3,
				160
			],
			"prefix_eff": [
				0,
				0
			],
			"sec_eff": [
				[
					8,
					12,
					0,
					0
				],
				[
					4,
					7,
					0,
					0
				],
				[
					10,
					15,
					0,
					0
				],
				[
					1,
					401,
					0,
					0
				]
			],
			"extra": 5
		}
	]
}
"""

let decoder = JSONDecoder()
let data = Data(json.utf8)

struct SummonerWrapper: Decodable {
	private enum CodingKeys: String, CodingKey {
		case wizard = "wizard_info"
	}
	var wizard: Summoner
}

let summonerWrapper = try decoder.decode(SummonerWrapper.self, from: data)
summoner = summonerWrapper.wizard

print(summoner.name)


//
//
//json = """
//[
//  {
//	"model": "bestiary.gameitem",
//	"pk": 1,
//	"fields": {
//	  "com2us_id": 2,
//	  "category": 6,
//	  "name": "Social Point",
//	  "icon": "social.png",
//	  "description": "",
//	  "slug": "social-point",
//	  "sell_value": null
//	}
//  },
//  {
//	"model": "bestiary.gameitem",
//	"pk": 2,
//	"fields": {
//	  "com2us_id": 1,
//	  "category": 6,
//	  "name": "Crystal",
//	  "icon": "crystal.png",
//	  "description": "Premium in-game currency",
//	  "slug": "crystal",
//	  "sell_value": null
//	}
//  },
//  {
//	"model": "bestiary.gameitem",
//	"pk": 3,
//	"fields": {
//	  "com2us_id": 3,
//	  "category": 6,
//	  "name": "Real Money",
//	  "icon": null,
//	  "description": "Currently not seen in game",
//	  "slug": "real-money",
//	  "sell_value": null
//	}
//  },
//  {
//	"model": "bestiary.gameitem",
//	"pk": 4,
//	"fields": {
//	  "com2us_id": 4,
//	  "category": 6,
//	  "name": "Glory Point",
//	  "icon": "glory_points.png",
//	  "description": "Currency gained from PVP",
//	  "slug": "glory-point",
//	  "sell_value": null
//	}
//  },
//  {
//	"model": "bestiary.gameitem",
//	"pk": 5,
//	"fields": {
//	  "com2us_id": 5,
//	  "category": 6,
//	  "name": "Guild Point",
//	  "icon": "guild_points.png",
//	  "description": "Currency rewarded from guild content",
//	  "slug": "guild-point",
//	  "sell_value": null
//	}
//  },
//  {
//   "model": "bestiary.gameitem",
//   "pk": 31,
//   "fields": {
//	 "com2us_id": 1004,
//	 "category": 29,
//	 "name": "Solid Iron Ore",
//	 "icon": "craftstuff_icon_0000_01_04.png",
//	 "description": "It's an iron ore from which you can acquire high-quality iron. Used as Craft material.",
//	 "slug": "solid-iron-ore",
//	 "sell_value": 1
//   }
//  },
//  {
//   "model": "bestiary.gameitem",
//   "pk": 32,
//   "fields": {
//	 "com2us_id": 1005,
//	 "category": 29,
//	 "name": "Shining Mythril",
//	 "icon": "craftstuff_icon_0000_01_05.png",
//	 "description": "It's a mysterious metal that's been blessed by Ameria, the Goddess of Serenity. Used as Craft material.",
//	 "slug": "shining-mythril",
//	 "sell_value": 1
//   }
//  },
//  {
//   "model": "bestiary.gameitem",
//   "pk": 33,
//   "fields": {
//	 "com2us_id": 1006,
//	 "category": 29,
//	 "name": "Thick Cloth",
//	 "icon": "craftstuff_icon_0000_01_06.png",
//	 "description": "It's a carefully woven cloth with high endurance. Used as Craft material.",
//	 "slug": "thick-cloth",
//	 "sell_value": 1
//   }
//  },
//  {
//	"model": "bestiary.building",
//	"pk": 1,
//	"fields": {
//	  "com2us_id": 4,
//	  "name": "Guardstone",
//	  "max_level": 20,
//	  "area": 0,
//	  "affected_stat": 2,
//	  "element": null,
//	  "stat_bonus": "[\"1.0\", \"2.0\", \"3.0\", \"4.0\", \"5.0\", \"6.0\", \"7.0\", \"8.0\", \"9.0\", \"10.0\", \"11.0\", \"12.0\", \"13.0\", \"14.0\", \"15.0\", \"16.0\", \"17.0\", \"18.0\", \"19.0\", \"20.0\"]",
//	  "upgrade_cost": "[\"25\", \"60\", \"95\", \"130\", \"165\", \"200\", \"235\", \"270\", \"305\", \"340\", \"375\", \"410\", \"445\", \"480\", \"515\", \"550\", \"585\", \"620\", \"655\", \"690\"]",
//	  "description": "",
//	  "icon_filename": "guardstone.png"
//	}
//  },
//  {
//	"model": "bestiary.building",
//	"pk": 2,
//	"fields": {
//	  "com2us_id": 15,
//	  "name": "Fire Sanctuary",
//	  "max_level": 20,
//	  "area": 0,
//	  "affected_stat": 1,
//	  "element": "fire",
//	  "stat_bonus": "[\"2.0\", \"3.0\", \"4.0\", \"5.0\", \"6.0\", \"7.0\", \"8.0\", \"9.0\", \"10.0\", \"11.0\", \"12.0\", \"13.0\", \"14.0\", \"15.0\", \"16.0\", \"17.0\", \"18.0\", \"19.0\", \"20.0\", \"21.0\"]",
//	  "upgrade_cost": "[\"45\", \"70\", \"95\", \"120\", \"145\", \"170\", \"195\", \"220\", \"245\", \"270\", \"295\", \"320\", \"345\", \"370\", \"395\", \"420\", \"445\", \"470\", \"495\", \"520\"]",
//	  "description": "",
//	  "icon_filename": "fire_sanctuary.png"
//	}
//  },
//  {
//	"model": "bestiary.building",
//	"pk": 3,
//	"fields": {
//	  "com2us_id": 16,
//	  "name": "Water Sanctuary",
//	  "max_level": 20,
//	  "area": 0,
//	  "affected_stat": 1,
//	  "element": "water",
//	  "stat_bonus": "[\"2.0\", \"3.0\", \"4.0\", \"5.0\", \"6.0\", \"7.0\", \"8.0\", \"9.0\", \"10.0\", \"11.0\", \"12.0\", \"13.0\", \"14.0\", \"15.0\", \"16.0\", \"17.0\", \"18.0\", \"19.0\", \"20.0\", \"21.0\"]",
//	  "upgrade_cost": "[\"45\", \"70\", \"95\", \"120\", \"145\", \"170\", \"195\", \"220\", \"245\", \"270\", \"295\", \"320\", \"345\", \"370\", \"395\", \"420\", \"445\", \"470\", \"495\", \"520\"]",
//	  "description": "",
//	  "icon_filename": "water_sanctuary.png"
//	}
//  }
//]
//"""
//
//public struct AnyDecodable : Decodable {
//
//  let value :Any
//
//  public init<T>(_ value :T?) {
//	self.value = value ?? ()
//  }
//
//  public init(from decoder :Decoder) throws {
//	let container = try decoder.singleValueContainer()
//
//	if let string = try? container.decode(String.self) {
//	  self.init(string)
//	} else if let int = try? container.decode(Int.self) {
//	  self.init(int)
//	} else {
//	  self.init(())
//	}
//	// handle all the different types including bool, array, dictionary, double etc
//  }
//}
//
//struct GameItem: Decodable {
//	private enum CodingKeys: String, CodingKey {
//		case com2usId = "com2us_id"
//		case name
//		case c2uDescription = "description"
//		case imageFilename = "icon"
//		case category
//		case slug
//	}
//
//	var pk: Int
//	var com2usId: Int
//	var name: String
//	var c2uDescription: String
//	var imageFilename: String
//	var category: Int
//	var slug: String
//
//	init(from decoder: Decoder) throws {
//		try self.init(from: decoder, pk: -1)
//	}
//
//	init(from decoder: Decoder, pk: Int) throws {
//		self.pk = pk
//		self.com2usId = try decoder.decode("com2us_id")
//		self.name = try decoder.decode("name")
//		self.c2uDescription = try decoder.decode("description")
//		self.imageFilename = try decoder.decode("icon")
//		self.category = try decoder.decode("category")
//		self.slug = try decoder.decode("slug")
//	}
//}
//
//struct Building: Decodable {
//	private enum CodingKeys: String, CodingKey {
//		case name
//		case com2usId = "com2us_id"
//		case maxLevel = "max_level"
//		case area
//		case affectedStat = "affected_stat"
//		case element
//		case statBonus = "stat_bonus"
////		case upgradeCost = "upgrade_cost"
//	}
//
//	var pk: Int
//	var com2usId: Int
//	var name: String
//	var maxLevel: Int
//	var area: Int
//	var affectedStat: Int
//	var element: String
//	var statBonus: [Double]
////	var upgradeCost: [Int]
//
//
//	init(from decoder: Decoder) throws {
//		try self.init(from: decoder, pk: -1)
//	}
//
//	init(from decoder: Decoder, pk: Int) throws {
//		self.pk = pk
//		self.com2usId = try decoder.decode("com2us_id")
//		self.name = try decoder.decode("name")
//		self.maxLevel = try decoder.decode("max_level")
//		self.area = try decoder.decode("area")
//		self.affectedStat = try decoder.decode("affectedStat")
//		self.element = try decoder.decode("element")
//
//		print("Getting container for janky")
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		print("Got Container, lets try Janky decoding")
////		var jankyString: JankyString = try container.decode(JankyString.self, forKey: .statBonus)
////		print(jankyString)
//
//		self.statBonus = [0.0]
//
////		self.statBonus = jsonArr.map {try! Double($0) ?? 0}
//
////		jsonArr = try decoder.decode("upgrade_cost", as: [String].self)
////		self.upgradeCost = jsonArr.map {try! Int($0) ?? 0}
////		self.upgradeCost = try decoder.decode("upgrade_cost")
//
////		var jsonArr = building.fields.stat_bonus.value
////		var converted = try! JSON(string: jsonArr as! String).array
//
//	}
//}
//
//struct BestiaryWrapper: Decodable {
//
//	private enum CodingKeys: String, CodingKey {
//		case model
//		case pk
//	}
//
//	var model: String
//	var pk: Int
//
//	var gameItems = [GameItem]()
//	var buildings = [Building]()
//
//	init(from decoder: Decoder) throws {
//		self.model = try decoder.decode("model")
//		self.pk = try decoder.decode("pk")
//
//		switch model {
//		case "bestiary.gameitem":
//			print("Game item!")
//
//			let gi: [[String: AnyDecodable]] = try decoder.decode("fields")
//			let item = try GameItem(from: gi as! Decoder, pk: self.pk)
//		case "bestiary.building":
//			print("Building!")
//		default:
//			print("   blep")
//		}
//	}
//}
//
//struct JankyString: Decodable {
//	private var str: String	// what we read in
//	var unjanked = [String]()
//
//	init(from decoder: Decoder) throws {
//
////		let container = try decoder.container(keyedBy: CodingKeys.self)
//		let container = try decoder.singleValueContainer()
//
//		print(container.codingPath)
//
//		str = ""
//	}
//}
//
//
//
//let decoder = JSONDecoder()
//decoder.allowsJSON5 = true
//
//let data = Data(json.utf8)
//
//let bestiaryWrapper = try decoder.decode(BestiaryWrapper.self, from: data)

//var json = """
//{"stat_bonus": "[\"2.0\", \"3.0\", \"4.0\", \"5.0\", \"6.0\", \"7.0\", \"8.0\", \"9.0\", \"10.0\", \"11.0\", \"12.0\", \"13.0\", \"14.0\", \"15.0\", \"16.0\", \"17.0\", \"18.0\", \"19.0\", \"20.0\", \"21.0\"]}
//"""
//
//json = json.replacingOccurrences(of: "\"[\"", with: "[\"")
//json = json.replacingOccurrences(of: "]\"", with: "]")
//json = json.replacingOccurrences(of: "\\\"", with: "\"")
//
//print(json)
//
//var dict: [String: [String]]
//var bonusints = [Double]()
//
//let data = Data(json.utf8)
//let decoder = JSONDecoder()
//dict = try decoder.decode(Dictionary.self, from: data)
//
//print(dict)
//if let bonuses = dict["stat_bonus"] {
//	bonusints = bonuses.compactMap { str in Double(str) }
//}
//
//print(bonusints[0] ?? -23)
//
////let container = try decoder.container(keyedBy: CodingKeys.self)
//
////let bonuses2 = try container.decode(keyedBy: [String].self, forKey: .statBonus)
//
//print(2 + 2 / 2 * 2)
//
//public enum ModelKeys: String, CodingKey {
//	case gameItem = "bestiary.gameitem"
//	case building = "bestiary.building"
//}


