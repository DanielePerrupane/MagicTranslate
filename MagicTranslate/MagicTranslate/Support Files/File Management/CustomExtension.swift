//
//  CustomExtension.swift
//  EncodingTest
//
//  Created by Matt Novoselov on 29/05/24.
//

import UniformTypeIdentifiers

extension UTType {
    static var magicTranslate: UTType {
        UTType(exportedAs: "dev.novoselov.magicTranslate")
    }
}
