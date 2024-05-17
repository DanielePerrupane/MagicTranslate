//
//  LanguagePickerView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 17/05/24.
//

import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    
    let availableLanguages = ["Italian", "English", "Uzbek", "Russian"]
    
    
    var body: some View {
        VStack {
            Text("Select the language you want to localize to")
                .font(.title)
                .bold()
            Picker("", selection: $selectedLanguage) {
                ForEach(availableLanguages, id: \.self) { language in
                    Text(language).tag(language)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
        }
    }
}

struct LanguagePickerView_Previews: PreviewProvider {
    @State static var selectedLanguage = "en"
    
    static var previews: some View {
        LanguagePickerView(selectedLanguage: $selectedLanguage)
    }
}
