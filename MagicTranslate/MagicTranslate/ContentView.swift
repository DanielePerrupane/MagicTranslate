//
//  ContentView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 13/05/24.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    
    @State var selectedImages: [NSImage] = []
    @State private var currentIndex: Int = 0
    
    var stringsCount: Int
    
    var body: some View {
        VStack {
            HStack {
                //OK
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(width: 450, height: 750)
                        .foregroundColor(.gray)
                    
                    if !selectedImages.isEmpty {
                        
                        DrawOverScreenshot(previewImage: selectedImages[currentIndex])
                        
                    } else {
                        Text("Drag & Drop screenshot")
                            .foregroundColor(.gray)
                    }
                }
                //OK
                VStack{
                    //1
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.color1)
                        .frame(height: 100)
                    
                    //2
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.color1)
                            .frame(height: 200)
                            .overlay(alignment: .bottom) {
                                
                                VStack {
                                    
                                    Text("Example")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .padding(.trailing)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.color2)
                                        .frame(height: 100)
                                        .padding(.bottom,10.0)
                                        .padding(.horizontal,10.0)
                                    
                                }.frame(height: 180)
                            }
                    }
                    //3 - bottom right
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(.gray)
                        .frame(height: 435)
                        .overlay(
                            //Show array of screenshot
                            ScrollView {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 10), spacing: 10) {
                                    ForEach(selectedImages.indices, id: \.self) { index in
                                        ZStack(alignment: .topTrailing) {
                                            Image(nsImage: selectedImages[index])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .padding(5)
                                            
                                            Button(action: {
                                                withAnimation {
                                                    if selectedImages.indices.contains(index) {
                                                        selectedImages.remove(at: index)
                                                    }
                                                }
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                            }
                                            .offset(x: -10, y: -10)
                                            
                                        }
                                    }
                                }
                                .padding(10)
                            }
                            
                        )
                }
                
            }
            .padding(10)
            
            let progressPercentage = selectedImages.isEmpty ? 0 : Int((Double(currentIndex + 1) / Double(stringsCount)) * 100)
            let percentageForegroundColor = Color("percentageForegroundColor")
            //ProgressView and Buttons for navigation
            HStack{
                
                //progress %
                Text("\(progressPercentage)%")
                    .padding(.leading,10)
                    .foregroundColor(percentageForegroundColor)
                
                CustomProgressViewStyle(
                    progress: Double(currentIndex + 1),
                    total: Double(selectedImages.count))
                    .padding(10)
                
                Spacer()
                
                //L
                Button(action: {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .padding()
                        .foregroundColor(.gray)
                }
                .disabled(currentIndex == 0)
                .padding(10)
                
                //R
                Button(action: {
                    if currentIndex < selectedImages.count - 1 {
                        currentIndex += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .padding()
                        .foregroundColor(.gray)
                }
                .disabled(currentIndex >= selectedImages.count - 1)
                
            }
            .padding(.trailing,10)
        }
    }
}




#Preview {
    ContentView(selectedImages: [
    
        
    
    ], stringsCount: 0)
}
