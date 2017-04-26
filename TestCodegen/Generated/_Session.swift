//
// _Session.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Session {

	let shiftEnds: Date?
	let emsAgency: EMSAgency
	let truck: Truck
	let user: User

	init(emsAgency: EMSAgency, shiftEnds: Date?, truck: Truck, user: User) {
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

func ==(lhs: Session, rhs: Session) -> Bool {
	return lhs.shiftEnds == rhs.shiftEnds && lhs.emsAgency == rhs.emsAgency && lhs.truck == rhs.truck && lhs.user == rhs.user 
}

func ==(lhs: Session?, rhs: Session?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Session]?, rhs: [Session]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
