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
        VStack(spacing: 20) {
            Text("Export and share .xcstrings file with a developer")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack {
                Button(action: {
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
                }) {
                    Text("Export File")
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 10.0)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                                .frame(width: 100)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .help(Text("Import .xcstrings file"))
                
                if let fileURL = fileURL {
                    ShareLink(item: fileURL, subject: Text("Your file")) {
                        Text("Share File")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 10.0)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                                    .frame(width: 100)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Export and Share .xcstrings")
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
