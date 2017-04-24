//
// ENTWSession.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWSession: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var shiftEnds: Date?

	//MARK: - One-to-one relationships
	dynamic var emsAgency: ENTWEMSAgency?
	dynamic var truck: ENTWTruck?
	dynamic var user: ENTWUser?

}
