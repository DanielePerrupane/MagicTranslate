//
//  PersonNameView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 23/05/24.
//

import SwiftUI

struct PersonNameView: View {
    
    
    @State var personName = ""
    
    var body: some View {
        VStack {
            TextField("Enter your name: ", text: $personName)
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

