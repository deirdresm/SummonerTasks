//
//  ArtifactInstance.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/2/20.
//

import Foundation
import CoreData

// MARK: - Core Data

// MARK: - Original SQL Table Definition

public struct ArtifactSecEffect: Codable {
	var statName: Int32
	var statValue: Double
	var numUpgrades: Int32
	var numRerolls: Int32
	var reserved: Int32 // there is a fifth field, not sure why
}


@objc(ArtifactInstance)
public class ArtifactInstance: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "rid"
        case summonerId = "wizard_id"
        case monsterId = "occupied_id"
        case slot = "type" // there's *also* a slot field, used for artifacts on monsters
        case unitArchetype = "unit_style" // Support, Attack, etc.
        case element = "attribute"
        case originalQuality = "natural_rank"
        case quality = "rank"
        case level
        case primaryEffect = "pri_effect"
        case secondaryEffects = "sec_effects"
    }

    required convenience public init(from decoder: Decoder) throws {
        // get the context and the entity in the context
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Could not get context [for ArtifactInstance]") }
        guard let entity = NSEntityDescription.entity(forEntityName: "ArtifactInstance", in: context) else { fatalError("Could not get entity [for ArtifactInstance]") }

        // init self
        self.init(entity: entity, insertInto: context)

        // create container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // and start decoding
        self.id = try container.decode(Int64.self, forKey: .id)
        self.summonerId = try container.decode(Int64.self, forKey: .summonerId)
        self.summoner = Summoner.findById(self.summonerId, context: context)
        self.monsterId = try container.decode(Int64.self, forKey: .monsterId)
        self.slot = try container.decode(Int16.self, forKey: .slot)
        self.unitArchetype = try container.decode(Int16.self, forKey: .unitArchetype)
        self.element = try container.decode(Int16.self, forKey: .element)
        self.level = try container.decode(Int16.self, forKey: .level)
        self.quality = try container.decode(Int16.self, forKey: .quality)
        self.originalQuality = try container.decode(Int16.self, forKey: .originalQuality)

		var primaryEffect = try container.decodeArray(Int16.self, forKey: .primaryEffect)
		self.mainStat = primaryEffect[0]
		self.mainStatValue = Int64(primaryEffect[1])
		
		var secEffWrapper = try container.nestedUnkeyedContainer(forKey: .secondaryEffects)
		let numStats = secEffWrapper.count ?? 0
		
		if numStats > 0 {
			var artifactStat = try secEffWrapper.nestedUnkeyedContainer()
			self.substat1 = try Int64(artifactStat.decode(Int.self))
			self.substat1Value = try artifactStat.decode(Double.self)
			self.substat1Enchanted = try artifactStat.decode(Int.self) != 0
			self.substat1Craft = try Int64(artifactStat.decode(Int.self))
			
			print("Substat1 = \(self.substat1)")
		}
		
		if numStats > 1 {
			var artifactStat = try secEffWrapper.nestedUnkeyedContainer()
			self.substat2 = try Int64(artifactStat.decode(Int.self))
			self.substat2Value = try artifactStat.decode(Double.self)
			self.substat2Enchanted = try artifactStat.decode(Int.self) != 0
			self.substat2Craft = try Int64(artifactStat.decode(Int.self))
		}
		
		if numStats > 2 {
			var artifactStat = try secEffWrapper.nestedUnkeyedContainer()
			self.substat3 = try Int64(artifactStat.decode(Int.self))
			self.substat3Value = try artifactStat.decode(Double.self)
			self.substat3Enchanted = try artifactStat.decode(Int.self) != 0
			self.substat3Craft = try Int64(artifactStat.decode(Int.self))
		}
		
		if numStats > 3 {
			var artifactStat = try secEffWrapper.nestedUnkeyedContainer()
			self.substat4 = try Int64(artifactStat.decode(Int.self))
			self.substat4Value = try artifactStat.decode(Double.self)
			self.substat4Enchanted = try artifactStat.decode(Int.self) != 0
			self.substat4Craft = try Int64(artifactStat.decode(Int.self))
		}
    }

    static var seenArtifacts = [ArtifactInstance]()

    static func findById(_ artifactInstanceId: Int64,
                                 context: NSManagedObjectContext = PersistenceController.shared.container.viewContext)
    -> ArtifactInstance? {
        
        let request : NSFetchRequest<ArtifactInstance> = ArtifactInstance.fetchRequest()

        request.predicate = NSPredicate(format: "id = %i", artifactInstanceId)
        
        if let results = try? context.fetch(request) {
        
            if let artifactInstance = results.first {
                return artifactInstance
            }
        }
        return nil
    }

    static func findSummonerArtifacts(docInfo: SummonerDocumentInfo) -> [ArtifactInstance] {

        let request : NSFetchRequest<ArtifactInstance> = ArtifactInstance.fetchRequest()

        request.predicate = NSPredicate(format: "summonerId = %i", docInfo.summonerId)

        if let results = try? docInfo.taskContext.fetch(request) {

            return results
        }
        return []
    }
    
//    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
//        
//        let artifactInstanceData = from as! ArtifactInstanceData
//        
//        // don't dirty the record if you don't have to
//        
//        if self.id != artifactInstanceData.com2usId {
//            self.id = artifactInstanceData.com2usId
//        }
//        if self.summonerId != artifactInstanceData.summonerId {
//            self.summonerId = artifactInstanceData.summonerId
//        }
//        if let summoner = docInfo.summoner {
//            self.summoner = summoner
//        }
//        if let summoner = docInfo.summoner {
//            if self.summoner != summoner {
//                self.summoner = summoner
//            }
//        }
//        if self.level != artifactInstanceData.level {
//            self.level = artifactInstanceData.level
//        }
//        if self.assignedToId != artifactInstanceData.monsterInstanceId {
//            self.assignedToId = artifactInstanceData.monsterInstanceId
//        }
//        if self.slot != artifactInstanceData.slot {
//            self.slot = artifactInstanceData.slot
//        }
//
//        if self.slot == ArtifactSlots.element.rawValue {
//            if let tempElement = Element(rawValue: artifactInstanceData.attribute) {
//                if self.element != tempElement.description {
//                    self.element = tempElement.description
//                }
//                self.archetype = nil
//            }
//        } else {
//            if let tempArchetype = ArchetypeChoices(rawValue: artifactInstanceData.unitStyle) {
//                if self.archetype != tempArchetype.description {
//                    self.archetype = tempArchetype.description
//                }
//                self.element = nil
//            }
//        }
//        if self.mainStat != artifactInstanceData.primaryEffect[0] {
//            self.mainStat = artifactInstanceData.primaryEffect[0]
//        }
//        if self.originalQuality != artifactInstanceData.naturalRank {
//            self.originalQuality = artifactInstanceData.naturalRank
//        }
//        if self.quality != artifactInstanceData.rank {
//            self.quality = artifactInstanceData.rank
//        }
//        if self.level != artifactInstanceData.level {
//            self.level = artifactInstanceData.level
//        }
//    }
//    
//    static func insertOrUpdate<T: JsonArray>(from: T,
//                               docInfo: SummonerDocumentInfo) {
//        docInfo.taskContext.performAndWait {
//            let artifactInstanceData = from as! ArtifactInstanceData
//            let artifactInstance = ArtifactInstance.findById(artifactInstanceData.com2usId, context: docInfo.taskContext) ?? ArtifactInstance(context: docInfo.taskContext)
//            artifactInstance.update(from: artifactInstanceData, docInfo: docInfo)
//            seenArtifacts.append(artifactInstance)
//        }
//    }
//    
//    static func batchUpdate<T: JsonArray>(from: [T],
//                            docInfo: SummonerDocumentInfo) {
//        seenArtifacts = []
//        let artifacts = from as! [ArtifactInstanceData]
//        for artifact in artifacts {
//            ArtifactInstance.insertOrUpdate(from: artifact, docInfo: docInfo)
//        }
//        docInfo.taskContext.perform {
//
//            // save first to make sure we've got a full house
//
//            do {
//                if docInfo.taskContext.hasChanges {
//                    try docInfo.taskContext.save()
//                }
//
//            } catch {
//                print("could not save context")
//            }
//
//            var summonerArtifacts = findSummonerArtifacts(docInfo: docInfo)
//            print("Have \(summonerArtifacts.count) summoner artifacts")
//
//            let notSeenArtifacts = summonerArtifacts.filter {!seenArtifacts.contains($0) }
//            print("Deleting \(notSeenArtifacts.count) we didn't see this time")
//
//            for i in 0 ..< notSeenArtifacts.count {
//                docInfo.taskContext.delete(notSeenArtifacts[i])
//            }
//            do {
//                if docInfo.taskContext.hasChanges {
//                    try docInfo.taskContext.save()
//                }
//
//            } catch {
//                print("could not save context")
//            }
//
//            seenArtifacts = [] // don't need to hang onto them
//        }
//    }
}



/*
    CREATE TABLE public.herders_artifactinstance
    (
     slot integer NOT NULL,
     element character varying(6) COLLATE pg_catalog."default",
     archetype character varying(10) COLLATE pg_catalog."default",
     quality integer NOT NULL,
     level integer NOT NULL,
     original_quality integer NOT NULL,
     main_stat integer NOT NULL,
     main_stat_value integer NOT NULL,
     effects integer[] NOT NULL,
     effects_value double precision[] NOT NULL,
     effects_upgrade_count integer[] NOT NULL,
     effects_reroll_count integer[] NOT NULL,
     id uuid NOT NULL,
     com2us_id bigint,
     assigned_to_id uuid,
     owner_id integer NOT NULL,
     efficiency double precision NOT NULL,
     max_efficiency double precision NOT NULL,
     CONSTRAINT herders_artifactinstance_pkey PRIMARY KEY (id),
     CONSTRAINT herders_artifactinst_assigned_to_id_05b980a1_fk_herders_m FOREIGN KEY (assigned_to_id)
         REFERENCES public.herders_monsterinstance (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED,
     CONSTRAINT herders_artifactinst_owner_id_2802668f_fk_herders_s FOREIGN KEY (owner_id)
         REFERENCES public.herders_summoner (id) MATCH SIMPLE
         ON UPDATE NO ACTION
         ON DELETE NO ACTION
         DEFERRABLE INITIALLY DEFERRED
    )
*/
