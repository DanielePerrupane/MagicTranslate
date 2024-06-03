//
//  getSupportedLanguages.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 23/05/24.
//

import Foundation

func getAllSupportedLanguagesWithNames() -> [(code: String, name: String)] {
    // Get the list of all available locale identifiers
    let localeIdentifiers = NSLocale.availableLocaleIdentifiers
    
    // Create a set to store unique language codes
    var languageCodes = Set<String>()
    
    // Iterate through each locale identifier
    for identifier in localeIdentifiers {
        // Extract the language code from the locale identifier
        let components = NSLocale.components(fromLocaleIdentifier: identifier)
        if let languageCode = components[NSLocale.Key.languageCode.rawValue] {
            languageCodes.insert(languageCode)
        }
    }
    
    // Convert the set to an array and sort it
    let sortedLanguageCodes = Array(languageCodes).sorted()
    
    // Create an array to store the language codes and their display names
    var languagesWithNames: [(code: String, name: String)] = []
    
    // Get the localized name for each language code
    for code in sortedLanguageCodes {
        let locale = NSLocale(localeIdentifier: code)
        if let languageName = locale.displayName(forKey: .languageCode, value: code) {
            languagesWithNames.append((code: code, name: languageName))
        }
    }
    
    return languagesWithNames
}
