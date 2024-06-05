//
//  CanvasData.swift
//  Draggy
//
//  Created by Matt Novoselov on 22/03/24.
//

import SwiftUI

enum Path {
    case developer
    case translator
}

@Observable
class LocalizationData: Codable {
    
    // Not savable properties
    var selectedPath: Path = .developer
    var selectedLanguage: String = "English"
    var selectedLanguageCode: String = "en"
    var personName: String = ""
    
    // Savable properties
    var localizationItems: [String: LocalizationItem] = [:]
    var projectName: String = "My project"
    
    enum CodingKeys: CodingKey {
        case localizationItems, projectName
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        localizationItems = try container.decode([String: LocalizationItem].self, forKey: .localizationItems)
        projectName = try container.decode(String.self, forKey: .projectName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(localizationItems, forKey: .localizationItems)
        try container.encode(projectName, forKey: .projectName)
    }
}

struct LocalizationItem: Codable {
    var translated: String = ""
    var comment: String = ""
    var screenshot: Data?
    var boundBox: BoundBox = BoundBox()

    enum CodingKeys: String, CodingKey {
        case translated, comment, screenshot, boundBox
    }
    
    func getNSImage() -> NSImage? {
        return NSImage(data: screenshot ?? Data())
    }
}

struct BoundBox: Codable {
    var xPos: CGFloat = 0
    var yPos: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var imageWidth: CGFloat = 1
}
