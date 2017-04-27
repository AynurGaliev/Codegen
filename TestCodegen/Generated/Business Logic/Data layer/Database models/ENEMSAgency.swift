//
// ENEMSAgency.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENEMSAgency: ENObject {

	//MARK: - Attributes
	dynamic var complaintSet: String?
	dynamic var id: String = ""
	let maxCaseLength = RealmOptional<Int>()
	dynamic var name: String = ""

	//MARK: - One-to-one relationships
	private let sessions = LinkingObjects(fromType: ENSession.self, property: "emsAgency")
	var session: ENSession? {
		return self.sessions.first
	}

	//MARK: - One-to-many relationships
	let cases = List<ENCase>()

	//MARK: - Many-to-many relationships
	let administrators =  LinkingObjects(fromType: ENUser.self, property: "emsAgenciesAdministered")
	let hospitals =  LinkingObjects(fromType: ENHospital.self, property: "emsAgencies")
	let members =  LinkingObjects(fromType: ENUser.self, property: "emsAgenciesAdministered")
	let trucks =  LinkingObjects(fromType: ENTruck.self, property: "agencies")

}
