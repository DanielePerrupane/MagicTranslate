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
            ScreenshotView(word: localizationData.extractedString[currentIndex])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ProgressView(currentIndex: $currentIndex)
        }

    }
}

#Preview {
    PathControllerView()
        .frame(width: 400, height: 400)
}
