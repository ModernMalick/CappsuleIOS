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
	@AppStorage("boarded") private var boarded = false
	
    var body: some Scene {
		WindowGroup {
			if(boarded){
				FrameView()
					.environment(\.managedObjectContext, persistenceContainer.container.viewContext)
			} else {
				Welcome()
			}
        }
    }
}

