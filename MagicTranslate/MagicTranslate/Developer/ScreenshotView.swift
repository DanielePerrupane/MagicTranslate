//
//  ScreenshotView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 21/05/24.
//

import SwiftUI
import PhotosUI

struct ScreenshotView: View {
    
    var stringsCount: Int
    var projectName: String
    
    @State private var arrayString: [String]?
    @State private var word = ""
    @State private var note = ""
    @State private var selectedImages: [NSImage] = []
    //@State private var selectedImageData: Data? = nil
    //@State private var selectedItem: PhotosPickerItem? = nil
    
    
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
                
                if selectedImages.isEmpty {
                    VStack{
                        Text("+")
                            .font(.largeTitle)
                            .fontWeight(.light)
                        Text("Drag&Drop an image here")
                    }
                    
                } else {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 10), spacing: 10) {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                ZStack(alignment: .topTrailing) {
                                    Image(nsImage: selectedImages[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding(5)
                                    
                                    Button(action: {
                                        withAnimation {
                                            if selectedImages.indices.contains(index) {
                                                selectedImages.remove(at: index)
                                            }
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                    .offset(x: -10, y: -10)
                                    
                                }
                            }
                        }
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(projectName)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: ContentView(selectedImages: selectedImages, stringsCount: stringsCount)) {
                    Text("Done")
                        .padding(3.0)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.blue)
                .cornerRadius(3.0)
            }
        }
    }
    
    private func handleOnDrop(providers:[NSItemProvider]) -> Bool {
        var handled = false
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.file-url") {
                provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { data, error in
                    if let data = data as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil),
                       url.isFileURL,
                       let imageData = try? Data(contentsOf: url),
                       let nsImage = NSImage(data: imageData) {
                        
                        DispatchQueue.main.async {
                            selectedImages.append(nsImage)
                        }
                        handled = true
                    }
                }
                return handled
            }
        }
        return handled
    }
}

#Preview {
    ScreenshotView(stringsCount: 0, projectName: "Example ProjectName")
}
