//
//  RuneColor.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//

import SwiftUI

// approach yanked from: https://twitter.com/mkj_is/status/1333792100199006213

enum RuneColor: String, View, CaseIterable {

    case legend, hero, rare, magic, normal

    // TODO: now that I've sorted out one data anomaly that may have caused the issue, re-check and see if I can make this better.
    // It wasn't sorting them, and I got tired of arguing
    // with various approaches. So. Let's do simple.
    static var gradient: Gradient {
        return Gradient(colors: [RuneColor.legend.body,
             RuneColor.hero.body,
             RuneColor.rare.body,
             RuneColor.magic.body,
             RuneColor.normal.body])
    }

    var body: Color {
        Color(rawValue)
    }
}

struct RuneColor_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            HStack {
                ForEach(Array(RuneColor.allCases.enumerated()), id: \.offset) { enumerated in
                    VStack {
                        enumerated.element
                            .overlay(Text(enumerated.element.rawValue)
                                        .font(.largeTitle))
                            .environment(\.colorScheme, .light)

                        enumerated.element
                            .overlay(Text(enumerated.element.rawValue)
                                        .font(.largeTitle))
                            .environment(\.colorScheme, .dark)
                    }
                }
            }
            LinearGradient(gradient: RuneColor.gradient, startPoint: .leading, endPoint: .trailing)
                .environment(\.colorScheme, .light)
            LinearGradient(gradient: RuneColor.gradient, startPoint: .leading, endPoint: .trailing)
                .environment(\.colorScheme, .dark)
        }
    }
}
