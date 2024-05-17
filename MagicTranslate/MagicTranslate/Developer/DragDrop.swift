//
//  Drag&Drop.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 14/05/24.
//

import SwiftUI

struct DragDrop: View {
    
    @State private var droppedFilePath: String?
    @State private var fileContent: String = ""
    @State private var jsonData: [String: Any] = [:]
    
    var body: some View {
        
        VStack {
            if let droppedFilePath = droppedFilePath {
                //After drag and drop
                ScrollView{
                    Text("File path: \(droppedFilePath)")
                        .padding()
                    Text("File content: ")
                        .padding(.top)
                    
                    if let strings = jsonData["strings"] as? [String: Any] {
                        ForEach(strings.keys.sorted(), id: \.self) { key in
                            Text(key)
                                .padding()
                        }
                    }
                    //                    Text(fileContent)
                    //                        .padding(.horizontal)
                }
                
            } else {
                //Before drag and drop
                //Text("Drag and Drop your localization file here")
                VStack {
                    ZStack {
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .frame(width: .infinity, height: .infinity)
                            .foregroundColor(.gray)
                        Text("Drag & Drop screenshot")
                            .foregroundColor(.gray)
                    }.padding()
                }
                .onDrop(of: ["public.file-url"], isTargeted: nil) { providers in
                    for provider in providers {
                        //Load dropped file path
                        provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { data, error in
                            if let data = data as? Data,
                               let url = URL(dataRepresentation: data, relativeTo: nil),
                               url.isFileURL,
                               //check file format
                               url.pathExtension == "xcstrings" {
                                
                                
                                self.droppedFilePath = url.path
                                
                                //Read file content and parse JSON
                                if let contentData = try? Data(contentsOf: url),
                                   let json = try? JSONSerialization.jsonObject(with: contentData, options: []) as? [String: Any] {
                                    
                                    self.jsonData = json
                                    
                                }
                            }
                            else {
                                print("Invalid file format, please drop a .xcstrings file.")
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

#Preview {
    DragDrop()
}
