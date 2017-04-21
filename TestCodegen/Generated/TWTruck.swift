//
// TWTruck.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWTruck: TWObject {

	let id: String
	let isALS: Bool
	let name: String
	let agencies: [TWEMSAgency]?
	let cases: [TWCase]?
	let session: TWSession?

	init(agencies: [TWEMSAgency]?, cases: [TWCase]?, createdAt: Date, id: String, isALS: Bool, localUpdatedAt: Date, name: String, session: TWSession?, updatedAt: Date?) {
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

func ==(lhs: TWTruck, rhs: TWTruck) -> Bool {
	return lhs.id == rhs.id && lhs.isALS == rhs.isALS && lhs.name == rhs.name && lhs.agencies == rhs.agencies && lhs.cases == rhs.cases && lhs.session == rhs.session 
}

func ==(lhs: TWTruck?, rhs: TWTruck?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWTruck]?, rhs: [TWTruck]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
