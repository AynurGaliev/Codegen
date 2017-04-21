//
// TWHospital.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWHospital: TWObject {

	let id: String
	let location: CLLocation?
	let name: String
	let administrators: [TWUser]?
	let cases: [TWCase]?
	let emsAgencies: [TWEMSAgency]?
	let members: [TWUser]?

	init(administrators: [TWUser]?, cases: [TWCase]?, createdAt: Date, emsAgencies: [TWEMSAgency]?, id: String, localUpdatedAt: Date, location: CLLocation?, members: [TWUser]?, name: String, updatedAt: Date?) {
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

func ==(lhs: TWHospital, rhs: TWHospital) -> Bool {
	return lhs.id == rhs.id && lhs.location == rhs.location && lhs.name == rhs.name && lhs.administrators == rhs.administrators && lhs.cases == rhs.cases && lhs.emsAgencies == rhs.emsAgencies && lhs.members == rhs.members 
}

func ==(lhs: TWHospital?, rhs: TWHospital?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWHospital]?, rhs: [TWHospital]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
