//
// _Truck.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:34.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Truck: _Object {

	let id: String
	let isALS: Bool
	let name: String
	let agencies: [EMSAgency]?
	let cases: [Case]?
	let session: Session?

	init(agencies: [EMSAgency]?, cases: [Case]?, createdAt: Date, id: String, isALS: Bool, localUpdatedAt: Date, name: String, session: Session?, updatedAt: Date?) {
		self.agencies = agencies
		self.cases = cases
		self.id = id
		self.isALS = isALS
		self.name = name
		self.session = session
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let id: String = "id"
		static let isALS: String = "isALS"
		static let name: String = "name"
		static let agencies: String = "agencies"
		static let cases: String = "cases"
		static let session: String = "session"
	}
}

func ==(lhs: Truck, rhs: Truck) -> Bool {
	return lhs.id == rhs.id && lhs.isALS == rhs.isALS && lhs.name == rhs.name && lhs.agencies == rhs.agencies && lhs.cases == rhs.cases && lhs.session == rhs.session 
}

func ==(lhs: Truck?, rhs: Truck?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Truck]?, rhs: [Truck]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
