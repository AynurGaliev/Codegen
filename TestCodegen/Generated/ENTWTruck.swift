//
// ENTWTruck.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWTruck: ENTWObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var isALS: Bool = false
	dynamic var name: String = ""

	//MARK: - One-to-one relationships
	dynamic var session: ENTWSession?

	//MARK: - One-to-many relationships
	let agencies = List<ENTWEMSAgency>()
	let cases = List<ENTWCase>()

}
