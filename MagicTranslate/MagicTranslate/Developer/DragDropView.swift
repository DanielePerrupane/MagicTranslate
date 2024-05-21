//
//  Drag&Drop.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 14/05/24.
//

import SwiftUI

struct DragDropView: View {
    
    @State private var droppedFilePath: String?
    @State private var fileContent: String = ""
    @State private var jsonData: [String: Any] = [:]
    @State private var errorMessage: String?
    @State private var navigateToNextView = false
   
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if droppedFilePath != nil {
                    //After drag and drop
                    ScrollView{
                        
                        VStack{
                            Text("File content: ")
                                .padding(.top)
                            
                            if let strings = jsonData["strings"] as? [String: Any] {
                                ForEach(strings.keys.sorted(), id: \.self) { key in
                                    Text(key)
                                        .padding()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)


                        }
                        .padding(.horizontal,1)
                        .navigationTitle("File Content")
                        .toolbar{
                            ToolbarItem{
                                NavigationLink(destination: ProjectNameView()) {
                                    Text("Done")
                                        .padding(3.0)
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .background(Color.blue)
                                .cornerRadius(3.0)
                            }
                            
                        }
                        
                    } else {
                        //Before drag and drop
                        VStack {
                            ZStack {
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .frame(width: .infinity, height: .infinity)
                                    .foregroundColor(.gray)
                                Text("Drag & Drop your localization file here")
                                    .foregroundColor(.gray)
                            }.padding()
                            
                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
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
                                        self.errorMessage = nil
                                        
                                        //Read file content and parse JSON
                                        if let contentData = try? Data(contentsOf: url),
                                           let json = try? JSONSerialization.jsonObject(with: contentData, options: []) as? [String: Any] {
                                            
                                            self.jsonData = json
                                            
                                        }
                                    }
                                    else {
                                        //Set error message
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
    DragDropView()
}
