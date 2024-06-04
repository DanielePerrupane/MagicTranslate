//
//  ShareFileView.swift
//  MagicTranslate
//
// Sharing added by Shox 03.06.2024
//
import SwiftUI

struct ExportMGTRView: View {

    @Environment(LocalizationData.self)
    private var localizationData: LocalizationData
    
    @State private var fileURL: URL?
    
    var body: some View {
        VStack {
            Text("Export and share .mgtr file with translator")
            
            Button(action: {
                exportFile(localizationData)
            }) {
                Text("Export File")
            }
            .padding()
            
            if let url = fileURL {
                ShareLink(item: url, subject: Text("Your file")) {
                    Text("Share the file")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func exportFile(_ data: LocalizationData) {
        let fileName = "exportedFile.mgtr"
        let fileManager = FileManager.default
        
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            let fileContents = "Sample data to be written to the file"
            try fileContents.write(to: fileURL, atomically: true, encoding: .utf8)
            
            self.fileURL = fileURL
        } catch {
            print("Error exporting file: \(error)")
        }
    }
}

