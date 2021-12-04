//
//  CappsuleApp.swift
//  Shared
//
//  Created by Malick NDIAYE on 02/11/2021.
//

import SwiftUI

@main
struct CappsuleApp: App {
	
	let persistenceContainer = PersistenceController.shared
	
    var body: some Scene {
		WindowGroup {
            FrameView()
				.environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}

