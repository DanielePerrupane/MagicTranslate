//
//  NextView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 20/05/24.
//

import SwiftUI

struct EnterProjectNameView: View {
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        @Bindable var localizationData = localizationData
        
        VStack(spacing: 10){
            Text("Enter your project name")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 0) {
                TextField("Project name: ", text: $localizationData.projectName)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: Color.gray.opacity(0.5), textColor: .white, cornerRadius: 8, height: 40))
                    .frame(width: 170)
                
                NavigationLink(destination: ImportXCStringsView()){
                    Text("Done")
                        .padding(6.0)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.pastelBlue)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .cornerRadius(3.0)
            }
        }
        .frame(width: 400, height: 400)
        .padding()
        .navigationTitle("Project Setup")
    }
}

#Preview {
    EnterProjectNameView()
}
