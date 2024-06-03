//
//  ShareFileView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 29/05/24.
//

import SwiftUI

struct ExportMGTRView: View {
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        VStack{
            Text("Export and share .mgtr file with translator")
            
            Button("Export") {
                exportFile(localizationData)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
