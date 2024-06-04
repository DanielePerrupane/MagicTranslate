//
//  ImportMGTR.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 02/06/24.
//

import SwiftUI


struct ImportMGTRView: View {
    
    @State private var isImported: Bool = false
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        VStack {
            if isImported{
                // After import
                
                ContentUnavailableView {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.greenAccept)
                        .font(.system(size: 70))
                } description: {
                    Text(".mgtr imported successfully")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .navigationTitle("File Content")
                .toolbar{
                    ToolbarItem{
                        NavigationLink(destination: EnterPersonNameView()) {
                            Text("Done")
                                .padding(3.0)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(.blue)
                        .cornerRadius(3.0)
                    }
                }
                
            } else{
                // Before import
                Button("Import File") {
                    importFile { data in
                        if let data = data {
                            localizationData.projectName = data.projectName
                            localizationData.localizationItems = data.localizationItems
                            isImported = true
                            localizationData.selectedPath = .translator
                        }
                    }
                }
            }
        }
        .frame(minWidth: 200, minHeight: 200)
        
    }
}
