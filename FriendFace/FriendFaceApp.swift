//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Viktor Mauzer on 03.01.2022..
//

import SwiftUI

@main
struct FriendFaceApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
