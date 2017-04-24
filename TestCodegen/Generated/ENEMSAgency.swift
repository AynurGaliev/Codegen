//
// ENEMSAgency.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
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

	//MARK: - Relationships
	let administrators = List<ENUser>()
	let cases = List<ENCase>()
	let hospitals = List<ENHospital>()
	let members = List<ENUser>()
	dynamic var session: ENSession?
	let trucks = List<ENTruck>()

}
