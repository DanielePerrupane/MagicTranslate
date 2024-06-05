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
                .font(.title2)
                .fontWeight(.semibold)
            
            TextField("Your name: ", text: $localizationData.personName)
                .frame(width: 170)
                .textFieldStyle(CustomTextFieldStyle(backgroundColor: Color.gray.opacity(0.5), textColor: .white, cornerRadius: 8, height: 40))
            
            NavigationLink(destination: LanguagePickerView()){
                Text("Done")
                    .padding(6.0)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.pastelBlue)
            .cornerRadius(3.0)
        }
        .frame(width: 400, height: 400)
        .padding()
        .navigationTitle("Setup")
        
    }
}

