//
//  MagicTranslateApp.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 13/05/24.
//

import SwiftUI

@main
struct MagicTranslateApp: App {
    
    @State var localizationData: LocalizationData = LocalizationData()
    
    var body: some Scene {
        WindowGroup {
            PathPickerView()
                .environment(localizationData)
        }
    }
}
