//
//  TranslatorsNoteView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct TranslatorsNoteView: View {
    
    @Binding var localizationItem: LocalizationItem
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Tranlsator's Notes".uppercased())
                .foregroundColor(.white)
                .font(.title3)
                .padding(.top,10)
                .padding(.horizontal,10)
            
            TextField("Enter text here", text: $localizationItem.comment)
                .padding(.bottom,10)
                .padding(.horizontal,10)
                .frame(maxWidth: .infinity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(localizationData.selectedPath == .translator ? true : false)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.31, green: 0.31, blue: 0.31)))
        .padding(10)
        
    }
}
