//
// _TWSession.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWSession {

	let shiftEnds: Date?
	let emsAgency: TWEMSAgency
	let truck: TWTruck
	let user: TWUser

	init(emsAgency: TWEMSAgency, shiftEnds: Date?, truck: TWTruck, user: TWUser) {
		self.emsAgency = emsAgency
		self.shiftEnds = shiftEnds
		self.truck = truck
		self.user = user
	}

	enum Keys {
		static let shiftEnds: String = "shiftEnds"
		static let emsAgency: String = "emsAgency"
		static let truck: String = "truck"
		static let user: String = "user"
	}
}

func ==(lhs: TWSession, rhs: TWSession) -> Bool {
	return lhs.shiftEnds == rhs.shiftEnds && lhs.emsAgency == rhs.emsAgency && lhs.truck == rhs.truck && lhs.user == rhs.user 
}

func ==(lhs: TWSession?, rhs: TWSession?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWSession]?, rhs: [TWSession]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
