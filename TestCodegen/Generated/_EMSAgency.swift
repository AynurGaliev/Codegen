//
// _EMSAgency.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _EMSAgency: _Object {

	let complaintSet: String?
	let id: String
	let maxCaseLength: Int?
	let name: String
	let administrators: [User]?
	let cases: [Case]?
	let hospitals: [Hospital]?
	let members: [User]?
	let session: Session?
	let trucks: [Truck]?

	init(administrators: [User]?, cases: [Case]?, complaintSet: String?, createdAt: Date, hospitals: [Hospital]?, id: String, localUpdatedAt: Date, maxCaseLength: Int?, members: [User]?, name: String, session: Session?, trucks: [Truck]?, updatedAt: Date?) {
		self.administrators = administrators
		self.cases = cases
		self.complaintSet = complaintSet
		self.hospitals = hospitals
		self.id = id
		self.maxCaseLength = maxCaseLength
		self.members = members
		self.name = name
		self.session = session
		self.trucks = trucks
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let complaintSet: String = "complaintSet"
		static let id: String = "id"
		static let maxCaseLength: String = "maxCaseLength"
		static let name: String = "name"
		static let administrators: String = "administrators"
		static let cases: String = "cases"
		static let hospitals: String = "hospitals"
		static let members: String = "members"
		static let session: String = "session"
		static let trucks: String = "trucks"
	}
}

func ==(lhs: EMSAgency, rhs: EMSAgency) -> Bool {
	return lhs.complaintSet == rhs.complaintSet && lhs.id == rhs.id && lhs.maxCaseLength == rhs.maxCaseLength && lhs.name == rhs.name && lhs.administrators == rhs.administrators && lhs.cases == rhs.cases && lhs.hospitals == rhs.hospitals && lhs.members == rhs.members && lhs.session == rhs.session && lhs.trucks == rhs.trucks 
}

func ==(lhs: EMSAgency?, rhs: EMSAgency?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [EMSAgency]?, rhs: [EMSAgency]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
