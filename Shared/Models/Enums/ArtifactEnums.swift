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

enum ArchetypeMap: Int64 {
    case none = 0, attack, defense, hp, support, material
    
    // return the text value of the label, lowercase
    var description: String {
        return "\(self)"
    }
}
