//
// ENSession.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENSession: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var shiftEnds: Date?

	//MARK: - Relationships
	dynamic var emsAgency: ENEMSAgency?
	dynamic var truck: ENTruck?
	dynamic var user: ENUser?

}
