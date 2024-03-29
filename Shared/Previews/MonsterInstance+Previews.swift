//
//  MonsterInstance+Previews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/31/20.
//

import Foundation
import CoreData

extension MonsterInstance {
    
    public static var baleygr: MonsterInstance {
        let monster = MonsterInstance(context: Persistence.shared.container.viewContext)
        
        
        
        return monster
    }
    
}

/*
 {
   "unit_id": 14591153200,
   "wizard_id": 12345678,
   "island_id": 7,
   "pos_x": 26,
   "pos_y": 2,
   "building_id": 0,
   "unit_master_id": 22612,
   "unit_level": 40,
   "class": 6,
   "con": 681,
   "atk": 790,
   "def": 670,
   "spd": 102,
   "resist": 15,
   "accuracy": 0,
   "critical_rate": 30,
   "critical_damage": 50,
   "experience": 1005420,
   "exp_gained": 0,
   "exp_gain_rate": 0,
   "skills": [
     [
       13102,
       9
     ],
     [
       13107,
       1
     ],
     [
       13112,
       4
     ]
   ],
   "runes": [
     {
       "rune_id": 28983545590,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 1,
       "rank": 5,
       "class": 6,
       "set_id": 15,
       "upgrade_limit": 15,
       "upgrade_curr": 15,
       "base_value": 602300,
       "sell_value": 32251,
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
           9,
           18,
           0,
           0
         ],
         [
           10,
           5,
           1,
           0
         ],
         [
           11,
           7,
           0,
           0
         ],
         [
           2,
           7,
           0,
           0
         ]
       ],
       "extra": 4
     },
     {
       "rune_id": 34481116710,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 2,
       "rank": 5,
       "class": 6,
       "set_id": 5,
       "upgrade_limit": 15,
       "upgrade_curr": 15,
       "base_value": 760800,
       "sell_value": 38040,
       "pri_eff": [
         4,
         63
       ],
       "prefix_eff": [
         9,
         6
       ],
       "sec_eff": [
         [
           6,
           13,
           0,
           5
         ],
         [
           11,
           4,
           0,
           0
         ],
         [
           8,
           11,
           0,
           2
         ],
         [
           2,
           12,
           0,
           0
         ]
       ],
       "extra": 4
     },
     {
       "rune_id": 33555457101,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 3,
       "rank": 5,
       "class": 6,
       "set_id": 15,
       "upgrade_limit": 15,
       "upgrade_curr": 14,
       "base_value": 475500,
       "sell_value": 25461,
       "pri_eff": [
         5,
         134
       ],
       "prefix_eff": [
         0,
         0
       ],
       "sec_eff": [
         [
           9,
           10,
           0,
           0
         ],
         [
           8,
           10,
           0,
           0
         ],
         [
           6,
           7,
           0,
           0
         ],
         [
           2,
           12,
           1,
           0
         ]
       ],
       "extra": 3
     },
     {
       "rune_id": 30340544965,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 4,
       "rank": 5,
       "class": 6,
       "set_id": 5,
       "upgrade_limit": 15,
       "upgrade_curr": 15,
       "base_value": 627660,
       "sell_value": 31383,
       "pri_eff": [
         10,
         80
       ],
       "prefix_eff": [
         0,
         0
       ],
       "sec_eff": [
         [
           4,
           19,
           0,
           0
         ],
         [
           9,
           10,
           0,
           0
         ],
         [
           2,
           7,
           0,
           6
         ],
         [
           6,
           8,
           1,
           5
         ]
       ],
       "extra": 5
     },
     {
       "rune_id": 32467237118,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 5,
       "rank": 5,
       "class": 6,
       "set_id": 5,
       "upgrade_limit": 15,
       "upgrade_curr": 15,
       "base_value": 608640,
       "sell_value": 30432,
       "pri_eff": [
         1,
         2448
       ],
       "prefix_eff": [
         9,
         5
       ],
       "sec_eff": [
         [
           8,
           6,
           0,
           3
         ],
         [
           2,
           5,
           0,
           0
         ],
         [
           10,
           27,
           0,
           0
         ],
         [
           5,
           29,
           0,
           0
         ]
       ],
       "extra": 5
     },
     {
       "rune_id": 34876777618,
       "wizard_id": 29593827,
       "occupied_type": 1,
       "occupied_id": 14591153200,
       "slot_no": 6,
       "rank": 5,
       "class": 6,
       "set_id": 5,
       "upgrade_limit": 15,
       "upgrade_curr": 12,
       "base_value": 592790,
       "sell_value": 29639,
       "pri_eff": [
         4,
         47
       ],
       "prefix_eff": [
         0,
         0
       ],
       "sec_eff": [
         [
           10,
           13,
           0,
           0
         ],
         [
           8,
           23,
           0,
           0
         ],
         [
           3,
           17,
           0,
           0
         ],
         [
           9,
           5,
           0,
           0
         ]
       ],
       "extra": 5
     }
   ],
   "artifacts": [
     {
       "rid": 26845935,
       "wizard_id": 29593827,
       "occupied_id": 14591153200,
       "slot": 2,
       "type": 2,
       "attribute": 0,
       "unit_style": 1,
       "natural_rank": 3,
       "rank": 5,
       "level": 15,
       "pri_effect": [
         101,
         100,
         15,
         0,
         0
       ],
       "sec_effects": [
         [
           204,
           4,
           0,
           0,
           2
         ],
         [
           409,
           13,
           2,
           0,
           0
         ],
         [
           213,
           3,
           0,
           0,
           0
         ],
         [
           214,
           3,
           0,
           0,
           0
         ]
       ],
       "locked": 0,
       "source": 50001,
       "extra": [],
       "date_add": "2020-09-03 14:39:23",
       "date_mod": "2020-12-16 18:00:25"
     },
     {
       "rid": 28017055,
       "wizard_id": 29593827,
       "occupied_id": 14591153200,
       "slot": 1,
       "type": 1,
       "attribute": 2,
       "unit_style": 0,
       "natural_rank": 3,
       "rank": 5,
       "level": 14,
       "pri_effect": [
         101,
         66,
         14,
         0,
         0
       ],
       "sec_effects": [
         [
           209,
           3,
           0,
           0,
           0
         ],
         [
           207,
           11,
           2,
           0,
           0
         ],
         [
           216,
           3,
           0,
           0,
           0
         ],
         [
           306,
           4,
           0,
           0,
           0
         ]
       ],
       "locked": 0,
       "source": 50001,
       "extra": [],
       "date_add": "2020-09-06 20:42:34",
       "date_mod": "2020-12-12 15:58:20"
     }

 */
