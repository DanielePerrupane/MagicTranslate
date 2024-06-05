//
//  XCStringsModel.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 04/06/24.
//

import AppKit
import UniformTypeIdentifiers

// Define the data model (assuming you already have this defined)
struct XCStringsModel: Codable {
    var projectName: String
    var sourceLanguage: String
    var strings: [String: StringData] = [:]
    var version: String
}

struct StringData: Codable {
    var comment: String?
    var localizations: [String: Localization]?
}

struct Localization: Codable {
    var stringUnit: StringUnit
}

struct StringUnit: Codable {
    var state: String = "translated"
    var value: String
}

// Function to export file with save panel
func exportXCStrings(_ data: XCStringsModel, completion: @escaping (URL?) -> Void) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
        let jsonData = try encoder.encode(data)
        
        // Present the save panel to the user
        let savePanel = NSSavePanel()
        savePanel.title = "Save Localization Data"
        savePanel.allowedContentTypes = [UTType.xcstrings]
        savePanel.nameFieldStringValue = "Localizable.xcstrings"
        
        savePanel.begin { response in
            if response == .OK {
                if let fileURL = savePanel.url {
                    // Ensure the file URL has the correct custom extension
                    let finalURL = fileURL.deletingPathExtension().appendingPathExtension("xcstrings")
                    do {
                        // Write the JSON data to the selected file URL
                        try jsonData.write(to: finalURL)
                        print("File saved to: \(finalURL.path)")
                        completion(finalURL)
                    } catch {
                        print("Failed to save file: \(error.localizedDescription)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } else {
                print("Save panel was canceled")
                completion(nil)
            }
        }
        
    } catch {
        print("Failed to encode data: \(error.localizedDescription)")
        completion(nil)
    }
}
