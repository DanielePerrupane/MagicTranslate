//
//  CanvasData.swift
//  Draggy
//
//  Created by Matt Novoselov on 22/03/24.
//

import Foundation

@Observable
class LocalizationData: Codable {
    var extractedString: [String] = []
    var projectName: String = "My project"
    
    enum CodingKeys: CodingKey {
        case extractedString, projectName
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        extractedString = try container.decode([String].self, forKey: .extractedString)
        projectName = try container.decode(String.self, forKey: .projectName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(extractedString, forKey: .extractedString)
        try container.encode(projectName, forKey: .projectName)
    }
}
