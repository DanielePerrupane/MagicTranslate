//
//  TranslatedWordView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct TranslatedWordView: View {
    
    @Binding var localizationItem: LocalizationItem
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {

        HStack{
            VStack(alignment: .leading, spacing: 5) {
                Text(localizationData.selectedLanguage.uppercased())
                    .foregroundColor(.white)
                    .font(.title3)
                
                TextField("Enter text here", text: $localizationItem.translated)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
