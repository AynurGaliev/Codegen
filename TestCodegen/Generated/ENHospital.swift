//
// ENHospital.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENHospital: ENObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var location: Data?
	dynamic var name: String = ""

	//MARK: - One-to-many relationships
	let cases = List<ENCase>()

	//MARK: - Many-to-many relationships
	let administrators =  LinkingObjects(fromType: ENUser.self, property: "hospitalsAdministrated")
	let emsAgencies = List<ENEMSAgency>()
	let members =  LinkingObjects(fromType: ENUser.self, property: "hospitalsAdministrated")

}
