//
//  PersistenceController.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 11/11/2021.
//

import CoreData

struct PersistenceController{
	static let shared = PersistenceController()
	
	let container: NSPersistentContainer
	
	init(){
		container = NSPersistentContainer(name: "Database")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error: \(error)")
			}
		}
	}
}
