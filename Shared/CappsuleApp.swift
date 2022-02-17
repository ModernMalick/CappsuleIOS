//
//  CappsuleApp.swift
//  Shared
//
//  Created by Malick NDIAYE on 02/11/2021.
//

import SwiftUI
import Purchases

@main
struct CappsuleApp: App {
	
	let persistenceContainer = PersistenceController.shared
	@AppStorage("boarded") private var boarded = false
	@AppStorage("tried") private var tried = false
	@AppStorage("subbed") private var subbed = false
	
	init() {
		Purchases.debugLogsEnabled = true
		Purchases.configure(withAPIKey: "appl_aOlCLwczNwxcMnQzJXqKpmTXgmD")
	}
	
    var body: some Scene {
		WindowGroup {
			if(boarded){
				if(tried){
					if(subbed) {
						FrameView()
							.environment(\.managedObjectContext, persistenceContainer.container.viewContext)
					} else {
						Subscribe()
					}
				} else {
					WelcomeSub()
				}
			} else {
				Welcome()
			}
        }
    }
}

