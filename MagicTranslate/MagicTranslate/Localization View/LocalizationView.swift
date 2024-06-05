//
//  ScreenshotView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 21/05/24.
//

import SwiftUI
import PhotosUI

struct LocalizationView: View {
    
    var localizationKey: String
    @Binding var localizationItem: LocalizationItem

    @State private var selectedImages: [NSImage] = []
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        HStack{
            // Image labeling
            ImageLabelingView(localizationItem: $localizationItem, localizationKey: localizationKey)
            
            VStack {
                // Original word
                OriginalWordView(localizationKey: localizationKey)
                
                //2 Text Field with title
                TranslatorsNoteView(localizationItem: $localizationItem)   
                
                //3 Text Field with title
                if localizationData.selectedPath == .translator{
                    TranslatedWordView(localizationItem: $localizationItem)
                }
                
                //4 Rectangle Image Picker
                if localizationData.selectedPath == .developer{
                    ImagePickerView(selectedImages: $selectedImages, localizationItem: $localizationItem, localizationKey: localizationKey)
                }
            }
        }
        .background(.red)
        .padding()
        .navigationTitle(localizationData.projectName)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                
                if localizationData.selectedPath == .developer{
                    NavigationLink(destination: ExportMGTRView()) {
                        Text("Done")
                            .padding(6.0)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(Color.blue)
                    .cornerRadius(3.0)
                } else{
                    NavigationLink(destination: ExportXCstringsView()) {
                        Text("Done")
                            .padding(6.0)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(Color.blue)
                    .cornerRadius(3.0)
                }
                
                
            }
        }
    }
}
