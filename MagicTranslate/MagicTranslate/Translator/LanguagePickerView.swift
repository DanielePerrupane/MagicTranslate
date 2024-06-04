//
//  LanguagePickerView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 17/05/24.
//

import SwiftUI

struct LanguagePickerView: View {
    
    @State private var selectedImages: [NSImage] = []
    
    let supportedLanguagesWithNames = getAllSupportedLanguagesWithNames()
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        @Bindable var localizationData = localizationData
        
        VStack {
            Text("Select the language you want to localize to")
                .font(.title)
                .bold()
            
            Picker("Language", selection: $localizationData.selectedLanguage) {
                ForEach(supportedLanguagesWithNames, id: \.code) { language in
                    Text(language.name).tag(language.name)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .onChange(of: localizationData.selectedLanguage) {
                if let selectedLanguageCode = supportedLanguagesWithNames.first(where: { $0.name == localizationData.selectedLanguage })?.code {
                    localizationData.selectedLanguageCode = selectedLanguageCode
                }
            }
            
            NavigationLink(destination: PathControllerView()){
                Text("Done")
                    .padding(3.0)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.blue)
            .cornerRadius(3.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LanguagePickerView()
}
