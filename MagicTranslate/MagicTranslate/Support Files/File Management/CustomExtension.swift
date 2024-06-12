//
//  CustomExtension.swift
//  EncodingTest
//
//  Created by Matt Novoselov on 29/05/24.
//

import UniformTypeIdentifiers

extension UTType {
    static var magicTranslate: UTType {
        UTType(exportedAs: "dev.novoselov.MagicTranslate.mgtr")
    }
}

// Define a custom UTType for .xcstrings
extension UTType {
    static var xcstrings: UTType {
        UTType(importedAs: "dev.novoselov.xcstrings")
    }
}
