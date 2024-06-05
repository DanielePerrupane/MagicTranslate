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
    
    @State private var isDragging: Bool = false
    
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
                    
                    let sizeMultiplier: CGFloat = proxy.size.width / localizationItem.boundBox.imageWidth
                    
                    PreviewImage(previewImage: previewImage)
                        .onAppear{
                            parseFromSaved()
                        }
                        .mask{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: rect.width * sizeMultiplier, height: rect.height * sizeMultiplier)
                                .position(x: rect.midX * sizeMultiplier, y: rect.midY * sizeMultiplier)
                        }
                        .overlay{
                            SelectionBoxDebugInfo(debugEnabled: false, rect: rect)
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
                        .onChange(of: isDragging){
                            localizationItem.boundBox.imageWidth = proxy.size.width
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
                    isDragging.toggle()
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
