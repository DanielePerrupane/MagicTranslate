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
            VStack{
                NavigationLink(destination: DragDropView()){
                    Text("Developer")
                        .padding(3.0)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.blue)
                .cornerRadius(3.0)
                
                NavigationLink(destination: PersonNameView()){
                    Text("Translator")
                        .padding(3.0)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.blue)
                .cornerRadius(3.0)
            }
        }
        .navigationTitle("Select your role")
    }
}

#Preview {
    PathPickerView()
}
