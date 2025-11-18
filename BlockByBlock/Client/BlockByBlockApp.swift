//
//  BlockByBlockApp.swift
//  BlockByBlock
//
//  Created by Dabian  on 10/27/25.
//

import SwiftUI

@main
struct BlockByBlockApp: App {
    @StateObject private var authController = AuthController()
    // load fonts onto app launch
    init() {
        FontLoader.loadCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
        }
    }
}
