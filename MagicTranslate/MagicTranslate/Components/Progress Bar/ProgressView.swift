//
//  ProgressView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 29/05/24.
//

import SwiftUI

struct ProgressView: View {
    
    @Binding var currentIndex: Int
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        
        HStack{
            //progress %
            Text(String(format: "%.0f%%", (Double(currentIndex + 1) / Double(localizationData.localizationItems.count)) * 100))
                .contentTransition(.numericText())
                .animation(.easeInOut, value: currentIndex)
            
            CustomProgressViewStyle(progress: Double(currentIndex + 1), total: Double(localizationData.localizationItems.count))
            
            Spacer()
            
            //L
            Button(action: {
                if currentIndex>0{
                    currentIndex -= 1
                }
            }) {
                Image(systemName: "arrow.left")
                    .padding()
                    .foregroundColor(.gray)
            }
            .disabled(currentIndex == 0)
            
            //R
            Button(action: {
                if currentIndex<localizationData.localizationItems.count-1{
                    currentIndex += 1
                }
            }) {
                Image(systemName: "arrow.right")
                    .padding()
                    .foregroundColor(.gray)
            }
            .disabled(currentIndex >= localizationData.localizationItems.count - 1)
        }
        .padding()
        
    }
}
