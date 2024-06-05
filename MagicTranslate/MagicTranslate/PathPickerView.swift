//
//  PathPickerView.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 23/05/24.
//

import SwiftUI

struct PathPickerView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20){
                Text("Select your role")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack {
                    NavigationLink(destination: EnterProjectNameView()) {
                        Text("Developer")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 10.0)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    
                    NavigationLink(destination: ImportMGTRView()) {
                        Text("Translator")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 10.0)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Select your role")
    }
}

#Preview {
    PathPickerView()
}
