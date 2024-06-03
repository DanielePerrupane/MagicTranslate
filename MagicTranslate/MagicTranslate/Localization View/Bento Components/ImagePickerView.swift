//
//  ImagePickerView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct ImagePickerView: View {
    
    @Binding var selectedImages: [NSImage]
    @Binding var localizationItem: LocalizationItem
    var localizationKey: String
    
    @State private var currentSelectedIndex: Int?
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
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
                    Text("Drag&Drop images here")
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 10), spacing: 10) {
                        ForEach(selectedImages.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                
                                // Add
                                Button(action: {
                                    withAnimation {
                                        localizationItem.screenshot = convertToPNGData(nsImage: selectedImages[index])
                                        currentSelectedIndex = index
                                    }
                                }) {
                                    Image(nsImage: selectedImages[index])
                                        .resizable()
                                        .scaledToFit()
                                        .overlay{
                                            // Dimming effect
                                            Color.black
                                                .opacity(currentSelectedIndex == index ? 0 : 0.5)
                                        }
                                        .onChange(of: localizationKey){
                                            currentSelectedIndex = nil
                                        }
                                        .frame(width: 100, height: 100)
                                        .padding(5)
                                }
                                .buttonStyle(PlainButtonStyle())

                                    // Delete
                                    Button(action: {
                                        withAnimation {
                                            if selectedImages.indices.contains(index) {
                                                selectedImages.remove(at: index)
                                            }
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                            .padding(.all, 5)
                                            .foregroundColor(.red)
                                            .background(.white)
                                            .clipShape(.circle)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                
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
