//
//  RuneChecker.swift
//  RuneChecker
//
//  Created by Deirdre Saoirse Moen on 10/3/21.
//

import SwiftUI

struct RuneChecker: View {
    var body: some View {
		VStack {
			Text("Rune Efficiency Quick Check")
				.font(.title)
			
			HStack {
				Text("Rune Type")
				.font(.headline)
				
				List {
					ForEach(RuneStatType.allCases, id: \.rawValue) { (runeStatType) in
						Text("\(runeStatType.name())")
					}
				} // List
			}
			
			Text("Main Stat")
				
		}
    }
}

struct RuneChecker_Previews: PreviewProvider {
    static var previews: some View {
        RuneChecker()
    }
}
