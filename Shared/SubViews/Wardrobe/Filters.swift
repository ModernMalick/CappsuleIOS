//
//  Filters.swift
//  Cappsule (iOS)
//
//  Created by Malick NDIAYE on 04/11/2021.
//

import Foundation

enum Types: String, CaseIterable, Identifiable {
	case AnyType
	case Layer
	case Top
	case Bottom
	case Shoes
	
	var id: String {self.rawValue}
}

enum Warmths: String, CaseIterable, Identifiable {
	case AnyWarmth
	case Light
	case Both
	case Heavy
	
	var id: String {self.rawValue}
}

enum Availabilities: String, CaseIterable, Identifiable {
	case AnyAvailability
	case Available
	case Unavailable
	
	var id: String {self.rawValue}
}
