//
//  ImageLabelingView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct ImageLabelingView: View {
    
    @Binding var localizationItem: LocalizationItem
    var localizationKey: String
    
    var body: some View {
        
        if (localizationItem.screenshot != nil) {
            if let nsImage = localizationItem.getNSImage(){
                DrawBoxView(localizationKey: localizationKey, localizationItem: $localizationItem, previewImage: nsImage)
            }
        }
        
    }
}
