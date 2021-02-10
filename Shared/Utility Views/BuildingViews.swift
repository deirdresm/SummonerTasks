//
//  BuildingViews.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/11/20.
//

import SwiftUI

struct BuildingIconView: View {
    var building: Building
    var level: Int64
    
    func levelString(level: Int64) -> String {
        if level == 0 {
            return ""
        }
        return "\(level)"
    }
    
    var LevelStringOverlay: some View {
        var width = CGFloat()
        return ZStack {
            Text(levelString(level: level))
                .frame(idealWidth: width, maxWidth: width,
                       idealHeight: width,
                       maxHeight: width)
                .foregroundColor(.white)
                .font(.headline)
                .accessibility(label: Text("Level \(level)"))
                .padding(3)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
        VStack {
            Image(
                ImageStore.loadImage(type: .buildings, name: building.imageFilename ?? ""),
                scale: 2,
                label: Text(building.name ?? "")
            )
            .frame(idealWidth: proxy.size.width, maxWidth: proxy.size.width,
                   idealHeight: proxy.size.width,
                   maxHeight: proxy.size.width)
            .overlay(LevelStringOverlay, alignment: .bottomTrailing)
            Text(building.name ?? "")
                .frame(idealWidth: proxy.size.width, maxWidth: proxy.size.width)
                .font(.caption)
                .accessibility(label: Text("Building \(building.name ?? "")"))
                .fixedSize(horizontal: true, vertical: true)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(EdgeInsets(top: 1, leading: 3, bottom: 3, trailing: 3))
        } // VStack
        } // GeometryReader
    }
}

struct BuildingIconView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BuildingIconView(building: Building.ancientSword, level: 0)
            BuildingIconView(building: Building.darkSanctuary, level: 5)
            BuildingIconView(building: Building.fallenAncientGuardian, level: 2)
        }
        .previewLayout(.fixed(width: 64, height: 100))
    }
}
