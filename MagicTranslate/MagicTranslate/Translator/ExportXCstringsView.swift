//
//  ExportXCstringsView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct ExportXCstringsView: View {
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    @State private var fileURL: URL?
    
    var body: some View {
        VStack{
            Text("Export and share .xcstrings file with the developer")
            
            Button("Export") {
                let exampleLocalizationData: XCStringsModel = composeXCStructure()

                // Call the export function, typically from a button action or menu item
                exportXCStrings(exampleLocalizationData) { fileURL in
                    if let fileURL = fileURL {
                        print("File successfully exported to \(fileURL)")
                        self.fileURL = fileURL
                    } else {
                        print("File export failed or was canceled")
                    }
                }
            }
            
            if let fileURL = fileURL {
                ShareLink(item: fileURL, subject: Text("Your file")) {
                    Text("Share the file")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func composeXCStructure() -> XCStringsModel{
        // Compose structure
        var exampleLocalizationData = XCStringsModel(projectName: localizationData.projectName, sourceLanguage: "en", version: "1.0")

        // Add each key and respected value for translated in each of localizationItems
        for (key, item) in localizationData.localizationItems {
            let stringUnit = StringUnit(value: item.translated)
            let localization = Localization(stringUnit: stringUnit)
            let stringData = StringData(comment: "Test comment", localizations: [localizationData.selectedLanguageCode: localization])
            exampleLocalizationData.strings.updateValue(stringData, forKey: key)
        }
        
        return exampleLocalizationData
    }
}
