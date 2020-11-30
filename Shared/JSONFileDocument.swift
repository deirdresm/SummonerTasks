//
//  JSONFileDocument.swift
//  SummonerTasksMac
//
//  Created by Deirdre Saoirse Moen on 11/27/20.
//  Copyright © 2020 Deirdre Saoirse Moen. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var jsonFiles: UTType {
        UTType(importedAs: "public.json")
    }
}

struct JsonFileDocument: FileDocument {
    var title = "Enter Title Here"

    static var readableContentTypes: [UTType] { [.jsonFiles] }

    init(fileWrapper: FileWrapper, contentType: UTType) throws {
        // Read the file's contents from fileWrapper.regularFileContents
    }
    
    init(configuration: ReadConfiguration) throws {
        <#code#>
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        <#code#>
    }
    
    func write(to fileWrapper: inout FileWrapper, contentType: UTType) throws {
        // Create a FileWrapper with the updated contents and set fileWrapper to it.
        // This is possible because fileWrapper is an inout parameter.
    }
}
