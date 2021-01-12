import Foundation
import CoreData

public struct BuildingData: JsonArray {
    
    static var items = [BuildingData]()

    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case name
        case com2usId = "com2us_id"
        case maxLevel
        case area
        case affectedStat
        case element
        case statBonus
        case upgradeCost
        case upgradeLimit
        case description
        case imageFilename
    }

    let id:             Int64
    let name:           String
    let com2usId:       Int64
    let maxLevel:       Int64
    let area:           Int64?
    let affectedStat:   Int64?
    let element:        String? // only non-null for elemental buildings
    let statBonus:      [Int64]
    let upgradeCost:    [Int64]
    let description:    String
    let imageFilename:  String

    public init(building: JSON, pk: Int64) {
        id = building.pk.int
        name = building.fields.name.string
        com2usId = building.fields.com2us_id.int
        maxLevel = building.fields.max_level.int
        area = building.fields.area.optionalInt
        affectedStat = building.fields.affected_stat.optionalInt
        element = building.fields.element.optionalString
        description = building.fields.description.string
        imageFilename = building.fields.icon_filename.string
        
        var jsonArr = building.fields.stat_bonus.value
        var converted = try! JSON(string: jsonArr as! String).array
        statBonus = converted.map {try! JSON(string: $0.value as! String).int}
//        print("statBonus: \(statBonus)")

        jsonArr = building.fields.upgrade_cost.value
        converted = try! JSON(string: jsonArr as! String).array
        upgradeCost =  converted.map {try! JSON(string: $0.value as! String).int}
//        print("upgradeCost: \(upgradeCost)")
    }
    
    static func saveToCoreData(_ docInfo: SummonerDocumentInfo) {
        
        docInfo.taskContext.perform {
            Building.batchUpdate(from: BuildingData.items,
                                 docInfo: docInfo)
            do {
                if docInfo.taskContext.hasChanges {
                    try docInfo.taskContext.save()
                }
                else
                {
                    print("No context changes for awaken cost data.")
                }

            } catch {
                print("could not save context")
            }
        }
    }
}

/*
 CREATE TABLE public.herders_buildinginstance
 (
     id uuid NOT NULL,
     level integer NOT NULL,
     building_id integer NOT NULL,
     owner_id integer NOT NULL,
     CONSTRAINT herders_buildinginstance_pkey PRIMARY KEY (id),
     CONSTRAINT herders_buildinginst_building_id_a46a1391_fk_bestiary_ FOREIGN KEY (building_id)
         REFERENCES public.bestiary_building (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_buildinginst_owner_id_01cec24f_fk_herders_s FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
 )

*/
