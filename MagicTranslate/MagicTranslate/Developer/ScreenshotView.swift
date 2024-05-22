//
//  ScreenshotView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 21/05/24.
//

import SwiftUI
import PhotosUI

struct ScreenshotView: View {
    var projectName: String
    @State private var arrayString: [String]?
    @State private var word = ""
    @State private var note = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        VStack {
            //1 TextField
            TextField("", text: $word)
                .padding(.top,10)
                .padding(.horizontal,10)
                .frame(maxWidth: .infinity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //2 Text Field with title
            VStack(alignment: .leading) {
                
                Text("Tranlsator's Notes".uppercased())
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.top,10)
                    .padding(.horizontal,10)
                
                TextField("Enter text here", text: $note)
                    .padding(.bottom,10)
                    .padding(.horizontal,10)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            .background(
                RoundedRectangle(cornerRadius: 3.0)
                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31)))
            .padding(10)
            
            
            //3 Rectangle Image Picker
            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray)
                    .padding(10)
                    .onDrop(of: ["public.file-url"], isTargeted: nil) { providers in
                        handleOnDrop(providers: providers)
                    }
                if let imageData = selectedImageData, let nsImage = NSImage(data: imageData) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .padding(10)
                } else {
                    Text("Drag&Drop an image here")
                }
                
//                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
//                    Text("Drag & Drop your screenshot")
//                    
//                }
                
//                .onChange(of: selectedItem) { newItem in
//                    Task {
//                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                            selectedImageData = data
//                        }
//                    }
//                }
//                
//                if let imageData = selectedImageData, let nsImage = NSImage(data: imageData) {
//                    Image(nsImage: nsImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .padding(10)
//                }
                
                
            }
        }
        .navigationTitle(projectName)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func handleOnDrop(providers:[NSItemProvider]) -> Bool {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.file-url") {
                provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, error in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil),
                       url.isFileURL,
                       let imageData = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.selectedImageData = imageData
                        }
                    }
                }
                return true
            }
        }
        return false
    }
}

#Preview {
    ScreenshotView(projectName: "Example ProjectName")
}
