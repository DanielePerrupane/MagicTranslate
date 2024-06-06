//
//  Drag&Drop.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 14/05/24.
//

import SwiftUI

struct ImportXCStringsView: View {
    
    @State private var droppedFilePath: String?
    @State private var fileContent: String = ""
    @State private var errorMessage: String?
    @State private var navigateToNextView = false
    
    @State private var stringsCount: Int = 0
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if droppedFilePath != nil {
                    VStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.greenAccept)
                            .font(.system(size: 50))
                        
                        Text(".xcstrings imported successfully")
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("File Content")
                    .toolbar{
                        ToolbarItem{
                            NavigationLink(destination: PathControllerView()) {
                                Text("Done")
                                    .padding(6.0)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .background(Color.pastelBlue)
                            .cornerRadius(3.0)
                        }
                        
                    }
                    
                } else {
                    //Before drag and drop
                    VStack {
                        ZStack {
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.gray)
                            Text("Drag & Drop your localization file here")
                                .foregroundColor(.gray)
                                .font(.title3)
                                .navigationTitle("Drag & Drop .xcstrings")
                        }.padding()
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .onDrop(of: ["public.file-url"], isTargeted: nil) { providers in
                        for provider in providers {
                            provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { data, error in
                                if let data = data as? Data,
                                   let url = URL(dataRepresentation: data, relativeTo: nil),
                                   url.isFileURL,
                                   url.pathExtension == "xcstrings" {
                                    
                                    self.droppedFilePath = url.path
                                    self.errorMessage = nil
                                    
                                    // Read file content and parse JSON
                                    if let contentData = try? Data(contentsOf: url),
                                       let json = try? JSONSerialization.jsonObject(with: contentData, options: []) as? [String: Any] {
                                        
                                        if let strings = json["strings"] as? [String: Any] {
                                            // Loop through each string in the dictionary
                                            for (key, value) in strings {
                                                // Extract the actual comment from the .xcstrings structure
                                                if let valueDict = value as? [String: Any]{
                                                    
                                                    var emptyLocalizationItem: LocalizationItem
                                                    
                                                    if let comment = valueDict["comment"] as? String {
                                                        // add with comment
                                                        emptyLocalizationItem = LocalizationItem(comment: comment)
                                                    } else{
                                                        // add without comment
                                                        emptyLocalizationItem = LocalizationItem()
                                                    }
                                                    
                                                    // append everything
                                                    // Add the new string to the localizationItems dictionary
                                                    DispatchQueue.main.async {
                                                        localizationData.localizationItems[key] = emptyLocalizationItem
                                                    }
                                                    
                                                    localizationData.selectedPath = .developer
                                                }
                                            }
                                        }
                                    }
                                    
                                } else {
                                    // Set error message
                                    DispatchQueue.main.async {
                                        self.errorMessage = "Invalid file format, please drop a .xcstrings file."
                                    }
                                }
                            }
                        }
                        return true
                    }
                }
            }
            .frame(minWidth: 200, minHeight: 200)
        }
    }
}

#Preview {
    ImportXCStringsView()
}
