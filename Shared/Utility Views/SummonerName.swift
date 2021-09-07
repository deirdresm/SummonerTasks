//
//  SummonerName.swift
//  SummonerName
//
//  Created by Deirdre Saoirse Moen on 9/6/21.
//

import SwiftUI

struct SummonerName: View {
    var summoner: Summoner?
    var prefix: String
    var suffix: String
    
    var body: some View {
        if let name = summoner?.name {
            Text("\(prefix)\(name)\(suffix)")
        } else {
            Text("\(prefix)\(suffix)")
        }
    }
}

struct SummonerName_Previews: PreviewProvider {
    static let summoner = Summoner.tisHerself

    static var previews: some View {
        Group {
            SummonerName(summoner: summoner, prefix: "Hello, ", suffix: ".")
            SummonerName(summoner: nil, prefix: "Hello", suffix: ".")
        }
    }
}
