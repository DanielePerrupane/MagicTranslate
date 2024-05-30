//
//  ImportFile.swift
//  EncodingTest
//
//  Created by Matt Novoselov on 29/05/24.
//

import AppKit

func importFile(completion: @escaping (LocalizationData?) -> Void) {
    let openPanel = NSOpenPanel()
    openPanel.title = "Open Localization Data"
    openPanel.allowedContentTypes = [.magicTranslate]
    
    openPanel.begin { response in
        if response == .OK {
            if let fileURL = openPanel.url {
                do {
                    let jsonData = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    let localizationData = try decoder.decode(LocalizationData.self, from: jsonData)
                    completion(localizationData)
                } catch {
                    print("Failed to open or decode file: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        } else {
            print("Open panel was canceled")
            completion(nil)
        }
    }
}
