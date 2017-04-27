//
// ENSession.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENSession: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var shiftEnds: Date?

	//MARK: - One-to-one relationships
	dynamic var emsAgency: ENEMSAgency?
	private let trucks = LinkingObjects(fromType: ENTruck.self, property: "session")
	var truck: ENTruck? {
		return self.trucks.first
	}
	private let users = LinkingObjects(fromType: ENUser.self, property: "session")
	var user: ENUser? {
		return self.users.first
	}

}
