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
    
    var body: some View {
        
        VStack {
            if let droppedFilePath = droppedFilePath {
                //Befor drag and drop
                Text("File path: \(droppedFilePath)")
                    .padding()
                Text("File content: ")
                    .padding(.top)
                Text(fileContent)
                    .padding(.horizontal)
                
            } else {
                
                //After drag and drop
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
                    print("prima del for")
                    for provider in providers {
                        print("entra nel for")
                        //Load dropped file path
                        provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { data, error in
                            if let data = data as? Data,
                               let url = URL(dataRepresentation: data, relativeTo: nil),
                               url.isFileURL{
                                print("url")
                                self.droppedFilePath = url.path
                                
                                //Read file content
                                if let content = try? String(contentsOf: url) {
                                    self.fileContent = content
                                }
                            }
                        }
                    }
                    print("completa il for")
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
