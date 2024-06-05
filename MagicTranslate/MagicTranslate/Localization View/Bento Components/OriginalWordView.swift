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
        
        HStack{
            VStack(alignment: .leading, spacing: 5) {
                Text("English".uppercased())
                    .foregroundColor(.white)
                    .font(.title3)
                
                Text(localizationKey)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background{
            Color(red: 0.31, green: 0.31, blue: 0.31)
                .cornerRadius(10)
        }
        
    }
}

#Preview {
    OriginalWordView(localizationKey: "Test")
}
