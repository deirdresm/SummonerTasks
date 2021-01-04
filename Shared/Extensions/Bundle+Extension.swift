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
    }
    
    func openBundleFile(from file: String) -> String {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return String(decoding: data, as: UTF8.self)

    }

}
