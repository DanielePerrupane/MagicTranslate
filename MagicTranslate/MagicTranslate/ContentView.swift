//
//  ContentView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 13/05/24.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    
    var selectedImages: [NSImage]
    @State private var currentIndex: Int = 0
    
    
    
    var body: some View {
        VStack {
            
            
            HStack {
                
                
                //OK
                ZStack {
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(width: 450, height: 750)
                        .foregroundColor(.gray)
                    
                    if !selectedImages.isEmpty {
                        Image(nsImage: selectedImages[currentIndex])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 450, height: 750)
                            .padding(10)
                    } else {
                        Text("Drag & Drop screenshot")
                            .foregroundColor(.gray)
                    }
                }
                //OK
                VStack{
                    //1
                    Rectangle()
                        .fill(Color("Color1"))
                        .cornerRadius(10.0)
                        .frame(height: 100)
                    //2
                    ZStack {
                        Rectangle()
                            .fill(Color("Color1"))
                            .cornerRadius(10.0)
                            .frame(height: 200)
                            .overlay(alignment: .bottom) {
                                
                                VStack {
                                    
                                    Text("Example")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .padding(.trailing)
                                    
                                    Rectangle()
                                        .fill(Color("Color2"))
                                        .frame(height: 100)
                                        .cornerRadius(10.0)
                                        .padding(.bottom,10.0)
                                        .padding(.horizontal,10.0)
                                    
                                }.frame(height: 180)
                            }
                    }
                    //3
                    
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(.gray)
                        .frame(height: 435)
                        .overlay(
                            Text("Drag & Drop or select screenshot")
                                .foregroundColor(.gray)
                        )
                }
                
            }
            .padding(10)
            
            
            HStack{
                
                ProgressView(value: Double(currentIndex + 1), total: Double(selectedImages.count))
                    .frame(width: 450)
                    .foregroundColor(.gray)
                    .padding(10)
                
                Spacer()
                
                //Arrow Buttons for navigation
                Button(action: {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                
                }) {
                    Image(systemName: "arrow.left")
                        .padding()
                        //.background(Color.blue)
                        .foregroundColor(.gray)
                }
                .disabled(currentIndex == 0)
                .padding(10)
                
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
    
        
    
    ])
}
