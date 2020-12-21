//
//  Bundle+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 12/6/20.
//

import Foundation



extension Bundle {
    
    // convenience method to get the image file path
    
    static func imageFilePath(type: ImageType, name: String) -> String {
        let partialPath = type.rawValue
        let path = partialPath.appending("/\(name)")
        return(path)
//        if let path = Bundle.main.path(forResource: name, ofType: "png", inDirectory: partialPath) {
//            return path
//        }
//        print("if let failed")
//        return ""
    }
}
