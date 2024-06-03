//
//  PathControllerView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 29/05/24.
//

import SwiftUI

struct PathControllerView: View {
    
    @State private var currentIndex: Int = 0
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData

    var body: some View {
        
        VStack{
            if !localizationData.localizationItems.isEmpty {
                let keys = Array(localizationData.localizationItems.keys)
                let key = keys[currentIndex % keys.count] // Ensure index is within bounds

                // Create a binding for the localization item
                let localizationItemBinding = Binding(
                    get: { localizationData.localizationItems[key] ?? LocalizationItem() },
                    set: { localizationData.localizationItems[key] = $0 }
                )

                LocalizationView(localizationKey: key, localizationItem: localizationItemBinding)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("No items available")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            ProgressView(currentIndex: $currentIndex)
        }

    }
}

#Preview {
    PathControllerView()
        .frame(width: 400, height: 400)
}
