//
// ENHospital.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENHospital: ENObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var location: CLLocation?
	dynamic var name: String = ""

	//MARK: - One-to-many relationships
	let administrators =  LinkingObjects(fromType: ENUser.self, property: "hospitalsAdministrated")
	let cases = LinkingObjects(fromType: ENCase.self, property: "destinationHospital")
	let emsAgencies =  LinkingObjects(fromType: ENEMSAgency.self, property: "hospitals")
	let members =  LinkingObjects(fromType: ENUser.self, property: "hospitalsAdministrated")

}
