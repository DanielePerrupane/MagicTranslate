//
//  MagicTranslateApp.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 13/05/24.
//

import SwiftUI

@main
struct MagicTranslateApp: App {
    
    @State var localizationData = LocalizationData()
    
    var body: some Scene {
        WindowGroup {
//            PathPickerView()
            ContentView()
                .environment(localizationData)
        }
    }
}
