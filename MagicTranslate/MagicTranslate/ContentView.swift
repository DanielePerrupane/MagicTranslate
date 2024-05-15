//
//  ContentView.swift
//  MagicTranslate
//
//  Created by Daniele Perrupane on 13/05/24.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    
    
    
    var body: some View {
        VStack {
            
               
                HStack {
                    
                    
                    //OK
                    ZStack {
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .frame(width: 450, height: 750)
                            .foregroundColor(.gray)
                        Text("Drag & Drop screenshot")
                            .foregroundColor(.gray)
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
            
            
        }
        //4
        Rectangle()
            .fill(Color(red: 0.2980392156862745, green: 0.2980392156862745, blue: 0.3137254901960784))
            .cornerRadius(10.0)
            .padding(.horizontal,10)
            .padding(.bottom, 10)
    }
    
    
    
}


#Preview {
    ContentView()
}
