//
//  FusionContentView.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 11/16/19.
//  Copyright © 2019 Deirdre Saoirse Moen. All rights reserved.
//

import SwiftUI

struct MonsterIcon: View {
    var body: some View {
        Image("Images/monsters/unit_icon_0006_0_0.png")
    }
}

struct FusionContentView: View {
    var body: some View {
        MonsterIcon()
    }
}

struct FusionContentView_Previews: PreviewProvider {
    static var previews: some View {
        FusionContentView()
    }
}
