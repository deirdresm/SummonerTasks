//
//  SummonerName.swift
//  SummonerName
//
//  Created by Deirdre Saoirse Moen on 9/6/21.
//

import SwiftUI

struct SummonerName: View {
    let name: String
    let prefix: String
    let suffix: String
    
    var body: some View {
		if name.isEmpty {
            Text("\(prefix)\(name)\(suffix)")
        } else {
            Text("\(prefix)\(suffix)")
        }
    }
}

struct SummonerName_Previews: PreviewProvider {
    static let summonerName =  "TisHerself"

    static var previews: some View {
        Group {
            SummonerName(name: summonerName, prefix: "Hello, ", suffix: ".")
			SummonerName(name: "", prefix: "Hello", suffix: ".")
        }
    }
}
