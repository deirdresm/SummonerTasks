extension Optional where Wrapped == String {
	var orEmpty: String {
		self ?? ""
	}
}


var json = """
[
  {
	"model": "bestiary.building",
	"pk": 8,
	"fields": {
	  "com2us_id": 6,
	  "name": "Sky Tribe Totem",
	  "stat_bonus": ["1.0", "2.0", "2.5", "3.0", "4.0", "5.0", "5.5", "6.0", "7.0", "8.0", "8.5", "9.0", "10.0", "11.0", "11.5", "12.0", "13.0", "14.0", "14.5", "15.0"],
	}
  },
  {
	"model": "bestiary.building",
	"pk": 9,
	"fields": {
	  "com2us_id": 8,
	  "name": "Crystal Altar",
	  "stat_bonus": ["1.0", "2.0", "3.0", "4.0", "5.0", "6.0", "7.0", "8.0", "9.0", "10.0", "11.0", "12.0", "13.0", "14.0", "15.0", "16.0", "17.0", "18.0", "19.0", "20.0"],
	}
  },
  {
	"model": "bestiary.building",
	"pk": 10,
	"fields": {
	  "com2us_id": 36,
	  "name": "Flag of Battle",
	  "stat_bonus": ["1.0", "2.0", "3.0", "4.0", "5.0", "6.0", "7.0", "8.0", "9.0", "10.0", "11.0", "12.0", "13.0", "14.0", "15.0", "16.0", "17.0", "18.0", "19.0", "20.0"],
	}
  },
  {
	"model": "bestiary.building",
	"pk": 11,
	"fields": {
	  "com2us_id": 37,
	  "name": "Flag of Rage",
	  "stat_bonus": ["1.0", "2.0", "3.0", "5.0", "6.0", "7.0", "8.0", "9.0", "10.0", "12.0", "13.0", "15.0", "16.0", "17.0", "18.0", "20.0", "21.0", "22.0", "23.0", "25.0"],
	}
  },
]
"""


protocol JsonArray {
	associatedtype ItemsArray

	static var items: [ItemsArray] {get set}
}

public class Building: JsonArray {

	static var items = [Building]()

	public let id:             Int64
	public let name:           String
	public let com2usId:       Int64
	public var statBonus:      [Double]

	public init(building: JSON, pk: Int64) throws {
		id = pk
		name = building.name.string
		com2usId = building.com2us_id.int

		print("About to check jsonArr")
		var jsonArr = building.stat_bonus.array
//		print("jsonArr: \(jsonArr)")
//		do {
//			var converted = try JSON(string: jsonArr).array
//		} catch let error {
//			print("Error: \(error)")
//		}
		print("Converted…")

		statBonus = []
		print("Stat bonus mapping")

		for fragment in jsonArr {
//			print(fragment)
			statBonus.append(fragment.double)
		}

		statBonus = jsonArr.map { ($0.value) -> Double in
			return string
		}

		print(id)
		print(name)
		print(com2usId)
		print(statBonus)

//		jsonArr = building.fields.upgrade_cost.value
//		converted = try! JSON(string: jsonArr as! String).array
//		upgradeCost =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("upgradeCost: \(upgradeCost)")
	}
}

struct BestiaryWrapper {

	private enum CodingKeys: String, CodingKey {
		case model
		case pk
	}

	var model: String
	var pk: Int64
}

var object = try JSON(string: json)
var model:      String = ""
var pk:         Int64 = 0

for item in object {
	model = item.model.string
	pk = item.pk.int
	print(model, pk)

	switch model {
	case "bestiary.building":
		let newBuilding = try Building(building: item.fields, pk: pk)
		Building.items.append(newBuilding)
	default:
		print("nope!")
	} // switch
} // if

for item in Building.items {
	print(item.name, item.statBonus)
}
