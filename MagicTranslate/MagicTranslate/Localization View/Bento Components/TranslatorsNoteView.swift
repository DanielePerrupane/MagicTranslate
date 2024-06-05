//
//  TranslatorsNoteView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct TranslatorsNoteView: View {
    
    @Binding var localizationItem: LocalizationItem
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 5) {
                Text("Translator's Notes".uppercased())
                    .foregroundColor(.white)
                    .font(.title3)
                
                if localizationData.selectedPath == .translator{
                    Text(localizationItem.comment)
                        .foregroundStyle(.secondary)
                    
                } else{
                    TextField("Enter text here", text: $localizationItem.comment)
                        .frame(maxWidth: .infinity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            Spacer()
        }
        .padding()
        .background{
            Color(red: 0.31, green: 0.31, blue: 0.31)
                .cornerRadius(10)
        }
        
    }
}

#Preview {
    TranslatorsNoteView(localizationItem: .constant(LocalizationItem()))
        .environment(LocalizationData())
        .frame(width: 400, height: 400)
}
