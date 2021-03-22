//
//  ArtifactEnums.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/12/21.
//

import Foundation

//COM2US_ELEMENT_MAP = {
//    1: ELEMENT_WATER,
//    2: ELEMENT_FIRE,
//    3: ELEMENT_WIND,
//    4: ELEMENT_LIGHT,
//    5: ELEMENT_DARK,
//    6: ELEMENT_PURE,
//}

enum ArtifactSlots: Int64 {
    case element = 1, archetype

    var description: String {
        return "\(self)"
    }
}

enum ElementChoices: Int64 {
    case none = 0, water, fire, wind, light, dark

    // return the text value of the label, lowercase
    var description: String {
        return "\(self)"
    }
}

enum ArchetypeChoices: Int64 {
    case none = 0, attack, hp, support, defense, material

    // return the text value of the label, lowercase
    var description: String {
        return "\(self)"
    }
}

enum MainStatChoices: Int64 {
    case hp = 100, atk, def

    // return the text value of the label, lowercase
    var description: String {
        return "\(self)"
    }
}

/*

 MAIN_STAT_CHOICES = (
     (ArtifactObjectBase.STAT_HP, 'HP'),
     (ArtifactObjectBase.STAT_ATK, 'ATK'),
     (ArtifactObjectBase.STAT_DEF, 'DEF'),
 )

 SLOT_ELEMENTAL = 1
  SLOT_ARCHETYPE = 2

  SLOT_CHOICES = (
      (SLOT_ELEMENTAL, 'Element'),
      (SLOT_ARCHETYPE, 'Archetype'),
  )

  COM2US_SLOT_MAP = {
      1: SLOT_ELEMENTAL,
      2: SLOT_ARCHETYPE,
  }

 slot = models.IntegerField(choices=SLOT_CHOICES)
 element = models.CharField(max_length=6, choices=base.Elements.NORMAL_ELEMENT_CHOICES, blank=True, null=True)
 archetype = models.CharField(max_length=10, choices=base.Archetype.ARCHETYPE_CHOICES, blank=True, null=True)
 quality = models.IntegerField(default=0, choices=base.Quality.QUALITY_CHOICES)

 MAIN_STAT_CHOICES = (
     (ArtifactObjectBase.STAT_HP, 'HP'),
     (ArtifactObjectBase.STAT_ATK, 'ATK'),
     (ArtifactObjectBase.STAT_DEF, 'DEF'),
 )

 COM2US_MAIN_STAT_MAP = {
     100: ArtifactObjectBase.STAT_HP,
     101: ArtifactObjectBase.STAT_ATK,
     102: ArtifactObjectBase.STAT_DEF,
 }

 MAIN_STAT_VALUES = {
     ArtifactObjectBase.STAT_HP: [160, 220, 280, 340, 400, 460, 520, 580, 640, 700, 760, 820, 880, 940, 1000, 1500],
     ArtifactObjectBase.STAT_ATK: [10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 100],
     ArtifactObjectBase.STAT_DEF: [10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 100],
 }

 */
