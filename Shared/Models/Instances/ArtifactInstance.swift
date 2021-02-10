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


extension ArtifactInstance: CoreDataUtility {
    
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
    
    func update<T: JsonArray>(from: T, docInfo: SummonerDocumentInfo) {
        
        let artifactInstanceData = from as! ArtifactInstanceData
        
        // don't dirty the record if you don't have to
        
        if self.id != artifactInstanceData.com2usId {
            self.id = artifactInstanceData.com2usId
        }
        if self.summonerId != artifactInstanceData.summonerId {
            self.summonerId = artifactInstanceData.summonerId
        }
        if let summoner = docInfo.summoner {
            self.summoner = summoner
        }
        if let summoner = docInfo.summoner {
            if self.summoner != summoner {
                self.summoner = summoner
            }
        }
        if self.level != artifactInstanceData.level {
            self.level = artifactInstanceData.level
        }
        if self.assignedToId != artifactInstanceData.monsterInstanceId {
            self.assignedToId = artifactInstanceData.monsterInstanceId
        }
        if self.slot != artifactInstanceData.slot {
            self.slot = artifactInstanceData.slot
        }
        if let tempArchetype = ArchetypeMap(rawValue: artifactInstanceData.artifactType) {
            if self.archetype != tempArchetype.description {
                self.archetype = tempArchetype.description
            }
        }
        if let tempElement = Element(rawValue: artifactInstanceData.attribute) {
            if self.element != tempElement.description {
                self.element = tempElement.description
            }
        }
        if self.mainStat != artifactInstanceData.unitStyle {
            self.mainStat = artifactInstanceData.unitStyle
        }
        if self.originalQuality != artifactInstanceData.naturalRank {
            self.originalQuality = artifactInstanceData.naturalRank
        }
        if self.quality != artifactInstanceData.rank {
            self.quality = artifactInstanceData.rank
        }
        if self.level != artifactInstanceData.level {
            self.level = artifactInstanceData.level
        }
        if self.level != artifactInstanceData.level {
            self.level = artifactInstanceData.level
        }
    }
    
    static func insertOrUpdate<T: JsonArray>(from: T,
                               docInfo: SummonerDocumentInfo) {
        docInfo.taskContext.performAndWait {
            let artifactInstanceData = from as! ArtifactInstanceData
            let artifactInstance = ArtifactInstance.findById(artifactInstanceData.com2usId, context: docInfo.taskContext) ?? ArtifactInstance(context: docInfo.taskContext)
            artifactInstance.update(from: artifactInstanceData, docInfo: docInfo)
        }
    }
    
    static func batchUpdate<T: JsonArray>(from: [T],
                            docInfo: SummonerDocumentInfo) {
        let artifacts = from as! [ArtifactInstanceData]
        for artifact in artifacts {
            ArtifactInstance.insertOrUpdate(from: artifact, docInfo: docInfo)
        }
    }
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
