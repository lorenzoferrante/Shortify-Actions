//
//  PreviewCard.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/16/20.
//

import Foundation
import SwiftUI
import UIKit
import LinkPresentation

struct URLPreview: UIViewRepresentable {
    
    var previewURL: URL
    
    func makeUIView(context: Context) -> LPLinkView {
        return LPLinkView(url: previewURL)
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    uiView.metadata = md
                    uiView.sizeToFit()
                }
            }
        }
    }
}
