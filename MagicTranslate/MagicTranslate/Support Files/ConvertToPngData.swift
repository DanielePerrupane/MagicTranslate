//
//  ConvertToPngData.swift
//  MagicTranslate
//
//  Created by Matt Novoselov on 03/06/24.
//

import SwiftUI

func convertToPNGData(nsImage: NSImage) -> Data? {
    if let tiffData = nsImage.tiffRepresentation,
       let bitmapImageRep = NSBitmapImageRep(data: tiffData) {
        return bitmapImageRep.representation(using: .png, properties: [:])
    }
    return nil
}
