//
//  OriginalWordView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

struct OriginalWordView: View {
    
    var localizationKey: String
    
    var body: some View {
        
        Text(localizationKey)
            .padding(.top, 10)
            .padding(.horizontal,10)
        
    }
}
