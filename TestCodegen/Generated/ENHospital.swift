//
// ENHospital.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

final class ENHospital: ENObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var location: CLLocation?
	dynamic var name: String = ""

	//MARK: - Relationships
	let administrators = List<ENUser>()
	let cases = List<ENCase>()
	let emsAgencies = List<ENEMSAgency>()
	let members = List<ENUser>()

}
