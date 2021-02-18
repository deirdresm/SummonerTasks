//
//  ElementCoor.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 2/17/21.
//

import SwiftUI

// approach yanked from: https://twitter.com/mkj_is/status/1333792100199006213

enum Element: Int64, View, CaseIterable {

        case water = 1, fire, wind, light, dark, pure

        static var magic: Element {
            get {
                return self.pure
            }
        }

        // return the text value of the label, lowercase
        var description: String {
            return "\(self)"
        }

        // return the text value of the label, but initial cap
        static func imageTitleFrag(_ element: Int64) -> String? {
            switch Element(rawValue: element) {
            case .water, .fire, .wind, .light, .dark:
                return ("\(self)").firstCapitalized // "Water"
            default:
                return nil
            }
        }

        // instance version of above
        public func imageTitleFrag() -> String? {
            switch self {
            case .water, .fire, .wind, .light, .dark:
                return ("\(self)").firstCapitalized // "Water"
            default:
                return nil
            }
        }

    static var gradient: Gradient {
        return Gradient(colors: [Element.water.body,
             Element.fire.body,
             Element.wind.body,
             Element.light.body,
             Element.dark.body])
    }

    var body: Color {
        Color("\(self)")
    }
}

struct Element_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            HStack {
                ForEach(Array(Element.allCases.enumerated()), id: \.offset) { enumerated in
                    VStack {
                        enumerated.element
                            .overlay(Text(enumerated.element.description)
                                        .font(.largeTitle))
                            .environment(\.colorScheme, .light)

                        enumerated.element
                            .overlay(Text(enumerated.element.description)
                                        .font(.largeTitle))
                            .environment(\.colorScheme, .dark)
                    }
                }
            }
            LinearGradient(gradient: Element.gradient, startPoint: .leading, endPoint: .trailing)
                .environment(\.colorScheme, .light)
            LinearGradient(gradient: Element.gradient, startPoint: .leading, endPoint: .trailing)
                .environment(\.colorScheme, .dark)
        }
    }
}
