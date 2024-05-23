//
//  LanguagePickerView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 17/05/24.
//

import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    
    let availableLanguages = [
        "Arabic",
        "Bengali",
        "Bhojpuri",
        "Burmese",
        "Cantonese (Yue Chinese)",
        "Dutch",
        "Egyptian Arabic",
        "English",
        "French",
        "German",
        "Gujarati",
        "Hausa",
        "Hindi",
        "Iranian Persian",
        "Italian",
        "Japanese",
        "Javanese",
        "Kannada",
        "Korean",
        "Malayalam",
        "Mandarin Chinese",
        "Marathi",
        "Odia (Oriya)",
        "Polish",
        "Portuguese",
        "Punjabi (Western)",
        "Russian",
        "Serbo-Croatian",
        "Southern Min",
        "Spanish",
        "Sundanese",
        "Tamil",
        "Telugu",
        "Thai",
        "Turkish",
        "Ukrainian",
        "Urdu",
        "Uzbek",
        "Vietnamese",
        "Wu Chinese"
    ]

    
    
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
