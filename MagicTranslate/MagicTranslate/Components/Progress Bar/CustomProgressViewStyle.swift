//
//  CustomP.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 29/05/24.
//

import SwiftUI

struct CustomProgressViewStyle: View {
    
    let progress: Double
    let total: Double
    
    let progressBackgroundColor = Color("progressBackgroundColor")
    let progressForegroundColor = Color("progressForegroundColor")
    
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                    //Background
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(progressBackgroundColor)
                        .frame(maxWidth: .infinity)
                        
                    
                    //Foreground (progress)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(progressForegroundColor)
                        .frame(width: (progress/total) * geometry.size.width)
            }
        }
        .frame(height: 10)
        .animation(.easeInOut, value: progress)
        
        
    }
    
}
