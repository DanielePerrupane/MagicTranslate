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
                exportMGTR(localizationData) { url in
                    self.fileURL = url
                }
            }) {
                Text("Export File")
            }
            .padding()
            
            if let fileURL = fileURL {
                ShareLink(item: fileURL, subject: Text("Your file")) {
                    Text("Share the file")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
