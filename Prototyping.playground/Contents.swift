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

let json = """
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
