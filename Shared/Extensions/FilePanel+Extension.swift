//
//  FilePanel+Extension.swift
//  SummonerTasksMac
//
//  Created by Deirdre Saoirse Moen on 11/11/20.
//  Copyright © 2020 Deirdre Saoirse Moen. All rights reserved.
//

import Cocoa

extension NSOpenPanel {
    
    static func openJSON(completion: @escaping (_ result: Result<NSImage, Error>) -> ()) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedFileTypes = ["json"]
        panel.canChooseFiles = true
        panel.begin { (result) in
            if result == .OK,
                let url = panel.urls.first,
                let image = NSImage(contentsOf: url) {
                completion(.success(image))
            } else {
                completion(.failure(
                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])
                ))
            }
        }
    }
}

//extension NSSavePanel {
//    
//    static func saveImage(_ image: NSImage, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
//        let savePanel = NSSavePanel()
//        savePanel.canCreateDirectories = true
//        savePanel.showsTagField = false
//        savePanel.nameFieldStringValue = "image.jpg"
//        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
//        savePanel.begin { (result) in
//            guard result == .OK,
//                let url = savePanel.url else {
//                completion(.failure(
//                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])
//                ))
//                return
//            }
//            
//            DispatchQueue.global(qos: .userInitiated).async {
//                guard
//                    let data = image.tiffRepresentation,
//                    let imageRep = NSBitmapImageRep(data: data) else { return }
//                
//                do {
//                    let imageData = imageRep.representation(using: .jpeg, properties: [.compressionFactor: 1.0])
//                    try imageData?.write(to: url)
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//}
