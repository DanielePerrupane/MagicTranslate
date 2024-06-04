//
//  ExportFile.swift
//  EncodingTest
//
//  Created by Matt Novoselov on 29/05/24.
//

import AppKit

func exportFile(_ data: LocalizationData) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
        let jsonData = try encoder.encode(data)
        
        // Present the save panel to the user
        let savePanel = NSSavePanel()
        savePanel.title = "Save Localization Data"
        savePanel.allowedContentTypes = [.magicTranslate]
        savePanel.nameFieldStringValue = "\(data.projectName)"
        
        savePanel.begin { response in
            if response == .OK {
                if let fileURL = savePanel.url {
                    // Ensure the file URL has the correct custom extension
                    let finalURL = fileURL.deletingPathExtension().appendingPathExtension(for: .magicTranslate)
                    do {
                        // Write the JSON data to the selected file URL
                        try jsonData.write(to: finalURL)
                        print("File saved to: \(finalURL.path)")
                    } catch {
                        print("Failed to save file: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Save panel was canceled")
            }
        }
        
    } catch {
        print("Failed to encode data: \(error.localizedDescription)")
    }
}