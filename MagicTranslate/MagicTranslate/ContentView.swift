//
//  ContentView.swift
//  EncodingTest
//
//  Created by Matt Novoselov on 29/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        @Bindable var localizationData = localizationData
        
        VStack{
            Text("Project name:")
            TextField("Project Name", text: $localizationData.projectName)
            
            Spacer()
            
            Text("Extracted string:")
            VStack{
                ForEach(localizationData.extractedString, id: \.self){ stringWord in
                    Text(stringWord)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button("Export to File") {
                exportFile(localizationData)
            }
            
            Button("Import File") {
                importFile { data in
                    if let data = data {
                        localizationData.extractedString = data.extractedString
                        localizationData.projectName = data.projectName
                    }
                }
            }
        }
        .padding()
        
    }
}
