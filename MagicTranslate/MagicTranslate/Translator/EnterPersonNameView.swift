//
//  PersonNameView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 23/05/24.
//

import SwiftUI

struct EnterPersonNameView: View {
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        @Bindable var localizationData = localizationData
        
        VStack {
            Text("Enter your name")
            
            TextField("Your name: ", text: $localizationData.personName)
                .frame(width: 170)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: LanguagePickerView()){
                Text("Done")
                    .padding(3.0)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.blue)
            .cornerRadius(3.0)
        }
        .frame(width: 400, height: 400)
        .padding()
        .navigationTitle("Setup")
        
    }
}

