//
// ENTWHospital.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWHospital: ENTWObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var location: CLLocation?
	dynamic var name: String = ""

	//MARK: - One-to-many relationships
	let administrators = List<ENTWUser>()
	let cases = List<ENTWCase>()
	let emsAgencies = List<ENTWEMSAgency>()
	let members = List<ENTWUser>()

}
