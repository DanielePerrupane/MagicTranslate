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
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.greenAccept)
                        .font(.system(size: 50))
                
                    Text(".mgtr imported successfully")
                        .font(.title3)
                }
                .navigationTitle("File Content")
                .toolbar{
                    ToolbarItem{
                        NavigationLink(destination: EnterPersonNameView()) {
                            Text("Done")
                                .padding(6.0)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(.pastelBlue)
                        .cornerRadius(3.0)
                    }
                }
                
            } else{
                // Before import
                
                VStack(spacing: 20) {
                    Text("Import an .mgtr file")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Button(action: {
                        importFile { data in
                            if let data = data {
                                localizationData.projectName = data.projectName
                                localizationData.localizationItems = data.localizationItems
                                isImported = true
                                localizationData.selectedPath = .translator
                            }
                        }
                    }) {
                        Text("Import .mgtr")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 10.0)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(minWidth: 200, minHeight: 200)
        .navigationTitle("Import .mgtr")
    }
}
