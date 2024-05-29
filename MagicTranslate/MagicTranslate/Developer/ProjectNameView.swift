//
//  NextView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 20/05/24.
//

import SwiftUI

struct ProjectNameView: View {
    
    @State var projectName = ""
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        VStack {
            TextField("Enter your project name: ", text: $projectName)
                .frame(width: 170)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: projectName){
                    localizationData.projectName = projectName
                }
            
            NavigationLink(destination: PathControllerView()){
                Text("Done")
                    .padding(3.0)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.blue)
            .cornerRadius(3.0)
        }
        .frame(width: 400, height: 400)
        .padding()
        .navigationTitle("Project Setup")
        
    }
}

#Preview {
    NavigationStack {
        ProjectNameView()
    }
}
