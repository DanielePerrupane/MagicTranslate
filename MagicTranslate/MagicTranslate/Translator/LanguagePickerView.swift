//
//  LanguagePickerView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 17/05/24.
//

import SwiftUI

struct LanguagePickerView: View {
    
    @State var selectedLanguage = "en"
    @State private var selectedImages: [NSImage] = []
    
    let supportedLanguagesWithNames = getAllSupportedLanguagesWithNames()
    
    
    var body: some View {
        VStack {
            Text("Select the language you want to localize to")
                .font(.title)
                .bold()
            
            Picker("Language", selection: $selectedLanguage) {
                ForEach(supportedLanguagesWithNames, id: \.code) { language in
                    Text(language.name).tag(language.code)
                }
            }
            .pickerStyle(.menu)
            .padding()
            
//            NavigationLink(destination: ContentView(selectedImages: selectedImages)){
                Text("Done")
                    .padding(3.0)
                    .foregroundColor(.white)
//            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.blue)
            .cornerRadius(3.0)
        }
    }
}

#Preview {
    LanguagePickerView()
}
