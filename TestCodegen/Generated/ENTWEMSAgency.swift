//
// ENTWEMSAgency.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWEMSAgency: ENTWObject {

	//MARK: - Attributes
	dynamic var complaintSet: String?
	dynamic var id: String = ""
	let maxCaseLength = RealmOptional<Int>()
	dynamic var name: String = ""

	//MARK: - One-to-one relationships
	dynamic var session: ENTWSession?

	//MARK: - One-to-many relationships
	let administrators = List<ENTWUser>()
	let cases = List<ENTWCase>()
	let hospitals = List<ENTWHospital>()
	let members = List<ENTWUser>()
	let trucks = List<ENTWTruck>()

}
