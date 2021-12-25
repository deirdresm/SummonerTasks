//
//  RuneTableView.swift
//  RuneTableView
//
//  Created by Deirdre Saoirse Moen on 9/7/21.
//

import SwiftUI
import CoreData

struct RuneDetail: View {
	@Environment(\.managedObjectContext) private var context
	
	let columns = [ GridItem(.adaptive(minimum: 100), spacing: 3) ]

	@State private var selectedRunes = Set<RuneInstance.ID>()
	
	@State var sortOrder: [SortDescriptor<RuneInstance>] = [
			.init(\.runeType, order: SortOrder.forward),
			.init(\.slot, order: SortOrder.forward)
		]
	
	@FetchRequest(
		entity: RuneInstance.entity(),
		sortDescriptors: [],
		predicate: NSPredicate(format: "name == %@", "Python")
	) var runes: FetchedResults<RuneInstance>
    
    var table: some View {
//		VStack {
//			Text("Header").font(.largeTitle)
//			TagCloudView(tags: ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"])
//			Text("Some other text")
//			Divider()
//			Text("Some other cloud")
//			TagCloudView(tags: ["Apple", "Google", "Amazon", "Microsoft", "Oracle", "Facebook"])
//		}
//
//		HStackWrap(models: [runes], viewGenerator: <#T##HStackWrap<_, _>.ViewGenerator##HStackWrap<_, _>.ViewGenerator##(_) -> _#>)
		Table(selection: $selectedRunes, sortOrder: $sortOrder) {
			
			TableColumn("Slot", value: \.slot) { rune in
				Text("\(rune.slot)")
			}

            TableColumn("Main Stat", value: \.mainStat) { rune in
                Text("\(rune.mainStat)")
            }

            TableColumn("Innate Stat", value: \.innateStat) { rune in
                Text("\(rune.innateStat)")
            }

        } rows: {
            ForEach(runes) { rune in
                TableRow(rune)
					.itemProvider { rune.itemProvider }
			}
		}
//            .onInsert(of: [Plant.draggableType]) { index, providers in
//                Plant.fromItemProviders(providers) { plants in
//                    garden.plants.insert(contentsOf: plants, at: index)
//                }
//            }
    }

	var body: some View {
		
		ScrollView {
			LazyVGrid(columns: columns, spacing: 20,
					pinnedViews: [.sectionHeaders]
				) {
				ForEach(runes, id: \.self) { rune in
					Text(verbatim: "\(rune.slot)")
				}
			}
			.padding(.horizontal)
		}
		.frame(maxHeight: 300)
	}
}

struct RuneDetail_Previews: PreviewProvider {
	
    static var previews: some View {
		RuneDetail()
    }
}
