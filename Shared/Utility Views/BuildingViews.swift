//
//  BuildingViews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/11/20.
//

import SwiftUI

struct BuildingIconView: View {
    var building: Building
    
    var body: some View {
        VStack {
            Image(
                ImageStore.loadImage(type: .buildings, name: building.imageFilename ?? ""),
                scale: 2,
                label: Text(building.name ?? "")
            )
            Text(building.name ?? "")
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(EdgeInsets(top: -5, leading: 3, bottom: 3, trailing: 3))
        }
    }
}

struct BuildingIconView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BuildingIconView(building: Building.ancientSword)
            BuildingIconView(building: Building.darkSanctuary)
        }
        .previewLayout(.fixed(width: 64, height: 100))
    }
}
