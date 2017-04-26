//
// _Hospital.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Hospital: _Object {

	let id: String
	let location: CLLocation?
	let name: String
	let administrators: [User]?
	let cases: [Case]?
	let emsAgencies: [EMSAgency]?
	let members: [User]?

	init(administrators: [User]?, cases: [Case]?, createdAt: Date, emsAgencies: [EMSAgency]?, id: String, localUpdatedAt: Date, location: CLLocation?, members: [User]?, name: String, updatedAt: Date?) {
		self.administrators = administrators
		self.cases = cases
		self.emsAgencies = emsAgencies
		self.id = id
		self.location = location
		self.members = members
		self.name = name
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let id: String = "id"
		static let location: String = "location"
		static let name: String = "name"
		static let administrators: String = "administrators"
		static let cases: String = "cases"
		static let emsAgencies: String = "emsAgencies"
		static let members: String = "members"
	}
}

func ==(lhs: Hospital, rhs: Hospital) -> Bool {
	return lhs.id == rhs.id && lhs.location == rhs.location && lhs.name == rhs.name && lhs.administrators == rhs.administrators && lhs.cases == rhs.cases && lhs.emsAgencies == rhs.emsAgencies && lhs.members == rhs.members 
}

func ==(lhs: Hospital?, rhs: Hospital?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Hospital]?, rhs: [Hospital]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
