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
        VStack(spacing: 20) {
            Text("Export and share .mgtr file with translator")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack {
                Button(action: {
                    exportMGTR(localizationData) { url in
                        self.fileURL = url
                    }
                }) {
                    Text("Export File")
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 10.0)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                                .frame(width: 100)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                
                if let fileURL = fileURL {
                    ShareLink(item: fileURL, subject: Text("Your file")) {
                        Text("Share File")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 10.0)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.31, green: 0.31, blue: 0.31))
                                    .frame(width: 100)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Export .mgtr")
    }
}
