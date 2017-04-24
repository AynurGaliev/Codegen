//
// ENTruck.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTruck: ENObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var isALS: Bool = false
	dynamic var name: String = ""

	//MARK: - Relationships
	let agencies = List<ENEMSAgency>()
	let cases = List<ENCase>()
	dynamic var session: ENSession?

}
