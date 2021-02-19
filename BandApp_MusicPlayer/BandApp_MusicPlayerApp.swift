//
//  BandApp_MusicPlayerApp.swift
//  BandApp_MusicPlayer
//
//  Created by David on 2021-02-03.
//

import SwiftUI
import Firebase

@main
struct BandApp_MusicPlayerApp: App {
    let data = MyData()
    
    init() {
        FirebaseApp.configure()
        data.loadAlbums()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
                .ignoresSafeArea()
        }
    }
}
