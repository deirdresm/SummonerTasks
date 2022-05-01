//
//  LeaderSkill.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData


// MARK: - Core Data

enum LeaderSkillStat: Int64 {
    case hp = 1, attack, defense, speed, critRate, critDamage, resist, accuracy
    
    static func imageTitleFrag(_ level: Int64) -> String? {
        switch LeaderSkillStat(rawValue: level) {
        case .hp:
            return "HP"
        case .attack:
            return "Attack_Power"
        case .defense:
            return "Defense"
        case .speed:
            return "Attack_Speed"
        case .critRate:
            return "Critical_Rate"
        case .critDamage:
            return "Critical_DMG" // there's always one
        case .resist:
            return "Resistance"
        case .accuracy:
            return "Accuracy"
        case .none:
            return nil
        }
    }
}

enum LeaderSkillArea: Int64 {
    case general = 1, arena, dungeon, guild

    static func imageTitleFrag(_ level: Int64) -> String? {
        switch LeaderSkillArea(rawValue: level) {
        case .arena:
            return "Arena"
        case .dungeon:
            return "Dungeon"
        case .guild:
            return "Guild"
        case .general, .none:
            return nil
        }
    }
    
    static func leaderSkillStringFrag(_ level: Int64) -> String? {
        switch LeaderSkillArea(rawValue: level) {
        case .arena:
            return "in the Arena "
        case .dungeon:
            return "in the Dungeons"
        case .guild:
            return "in Guild Content "
        case .general, .none:
            return nil
        }
    }
}



@objc(LeaderSkill)
public class LeaderSkill: NSManagedObject, Decodable {

	private enum CodingKeys: String, CodingKey {
		case id = "pk"
		case amount
		case area
		case attribute
		case element
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
		self.amount = try container.decode(Int64.self, forKey: .amount)
		self.area = try container.decode(Int64.self, forKey: .area)
		self.attribute = try container.decode(Int64.self, forKey: .attribute)
		let element = try container.decode(String.self, forKey: .element)
	}


	public convenience init(from decoder: Decoder, pk: Int64) throws {
		try self.init(from: decoder)
		self.id = pk
	}

    /*     def skill_string(self):
     if self.area == self.AREA_DUNGEON:
         condition = 'in the Dungeons '
     elif self.area == self.AREA_ARENA:
         condition = 'in the Arena '
     elif self.area == self.AREA_GUILD:
         condition = 'in Guild Content '
     elif self.area == self.AREA_ELEMENT:
         condition = 'with {} attribute '.format(self.get_element_display())
     else:
         condition = ''

     return "Increase the {0} of ally monsters {1}by {2}%".format(self.get_attribute_display(), condition, self.amount)
    */
    
    public func leaderSkillString() -> String {
        let areaFrag = LeaderSkillArea.leaderSkillStringFrag(self.area)
        var elementFrag: String?
        var attributeFrag: String?
        
        if let testElement = self.element {
            
            if let tempElement = Element.from(string: testElement) {
        
                if let elementFragTemp = Element.imageTitleFrag(tempElement.rawValue) {
                    elementFrag = elementFragTemp
                }
            }
        }
        
        if let statFrag = LeaderSkillStat.imageTitleFrag(self.attribute) {
            attributeFrag = statFrag
        } else {
            attributeFrag = ""
        }

        let condition = (areaFrag ?? elementFrag) ?? ""
        let skillString = "Increase the \(attributeFrag ?? "") of ally monsters \(condition )by \(amount)%"
        
        return skillString
    }
    
    // imageFileName examples:
    
    // leader_skill_Attack_Power_Arena.png <-- uses area
    // leader_skill_Attack_Power_Dark.png  <-- uses element
    // leader_skill_Attack_Power.png       <-- uses neither
    
    func imageFileName() -> String {
        var fileName = "leader_skill_"
        
        if let statFrag = LeaderSkillStat.imageTitleFrag(self.attribute) {
            fileName = fileName.appending(statFrag)
        }
        
        if let areaFrag = LeaderSkillArea.imageTitleFrag(self.area) {
            fileName = fileName.appending("_\(areaFrag)")
        }
        
        if let testElement = self.element {
            
            if let tempElement = Element.from(string: testElement) {
        
                if let elementFrag = Element.imageTitleFrag(tempElement.rawValue) {
                    fileName = fileName.appending("_\(elementFrag)")
                }
            }
        }

        return fileName
    }
    
    static func findById(_ skillDataId: Int64,
                         context: NSManagedObjectContext = Persistence.shared.container.viewContext)
    -> LeaderSkill? {
        
        let request : NSFetchRequest<LeaderSkill> = LeaderSkill.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", skillDataId)
        
        if let results = try? context.fetch(request) {
        
            if let skill = results.first {
                return skill
            }
        }
        return nil
    }

}


// MARK: - Original SQL Table Definition

/*
    CREATE TABLE public.bestiary_leaderskill
    (
        id integer NOT NULL DEFAULT nextval('bestiary_leaderskill_id_seq'::regclass),
        attribute integer NOT NULL,
        amount integer NOT NULL,
        area integer NOT NULL,
        element character varying(6) COLLATE pg_catalog."default",
        CONSTRAINT bestiary_leaderskill_pkey PRIMARY KEY (id)
    )
*/
