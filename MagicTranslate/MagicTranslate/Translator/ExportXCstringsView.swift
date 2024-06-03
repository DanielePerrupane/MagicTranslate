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
    
    var body: some View {
        VStack{
            Text("Export and share .xcstrings file with the developer")
            
            Button("Export") {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
