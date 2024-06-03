//
//  DrawOverScreenshot.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 17/05/24.
//

import SwiftUI

struct DrawBoxView: View {
    
    var localizationKey: String
    @State private var startLocation = CGPoint.zero
    @State private var currentLocation = CGPoint.zero
    
    @Binding var localizationItem: LocalizationItem
    var previewImage: NSImage
    
    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    var body: some View {
        PreviewImage(previewImage: previewImage)
            .overlay{
                Color.black
                    .opacity(0.4)
                
                GeometryReader { proxy in
                    let rect = CGRect(
                        x: min(startLocation.x, currentLocation.x),
                        y: min(startLocation.y, currentLocation.y),
                        width: abs(currentLocation.x - startLocation.x),
                        height: abs(currentLocation.y - startLocation.y)
                    )
                    
                    PreviewImage(previewImage: previewImage)
                        .mask{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: rect.width, height: rect.height)
                                .position(x: rect.midX, y: rect.midY)
                        }
                        .overlay{
                            SelectionBoxDebugInfo(debugEnabled: false, rect: rect)
                        }
                        .onAppear{
                            parseFromSaved()
                        }
                        .onChange(of: localizationKey){
                            parseFromSaved()
                        }
                        .onChange(of: rect){
                            localizationItem.boundBox.height = rect.height
                            localizationItem.boundBox.width = rect.width
                            localizationItem.boundBox.xPos = rect.minX
                            localizationItem.boundBox.yPos = rect.minY
                        }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            .gesture(dragGesture())
    }
    
    private func parseFromSaved(){
        startLocation.x = localizationItem.boundBox.xPos
        startLocation.y = localizationItem.boundBox.yPos
        currentLocation.x = startLocation.x + localizationItem.boundBox.width
        currentLocation.y = startLocation.y + localizationItem.boundBox.height
    }
    
    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                if localizationData.selectedPath == .developer{
                    startLocation = gesture.startLocation
                    currentLocation = gesture.location
                }
            }
    }
}

struct PreviewImage: View {
    var previewImage: NSImage
    
    var body: some View {
        Image(nsImage: previewImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct SelectionBoxDebugInfo: View {
    let debugEnabled: Bool
    var rect: CGRect
    
    var body: some View {
        if debugEnabled{
            Group{
                VStack(alignment: .leading){
                    Text("x: \(Int(rect.minX))")
                    Text("y: \(Int(rect.minY))")
                    Text("width: \(Int(rect.width))")
                    Text("height: \(Int(rect.height))")
                }
            }
            .foregroundStyle(.green)
            .fontWeight(.medium)
            .allowsHitTesting(false)
        }
    }
}
