//
//  Image+Extension.swift
//  Image+Extension
//
//  Created by Deirdre Saoirse Moen on 9/4/21.
//

import Foundation
import CoreData
import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct LoadedImage: View {
    @Binding var imageType: ImageType
    @State var imageName: String
    
    public var body: some View {
        Image(
            ImageStore.loadImage(type: imageType, name: "\(imageType.filePrefix)\(imageName).png"),
            scale: 1,
            label: Text("")
        )
    }
}
