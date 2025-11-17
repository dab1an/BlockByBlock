//
//  FontLoader.swift
//  BlockByBlock
//
//  Created by Richard Brito on 11/17/25.
//

import UIKit
import CoreText

class FontLoader {
    static func loadCustomFonts() {
        let fontNames = ["Mojang-Regular.ttf", "mojangles.otf"]
        
        for fontName in fontNames {
            guard let fontURL = Bundle.main.url(forResource: fontName.replacingOccurrences(of: ".ttf", with: "").replacingOccurrences(of: ".otf", with: ""), withExtension: fontName.contains(".ttf") ? "ttf" : "otf") else {
                print("Could not find font: \(fontName)")
                continue
            }
            
            guard let fontData = try? Data(contentsOf: fontURL),
                  let provider = CGDataProvider(data: fontData as CFData),
                  let font = CGFont(provider) else {
                print("Could not load font: \(fontName)")
                continue
            }
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("Error registering font \(fontName): \(error.debugDescription)")
            } else {
                if let postScriptName = font.postScriptName {
                    print("Successfully registered font: \(postScriptName)")
                }
            }
        }
    }
}
