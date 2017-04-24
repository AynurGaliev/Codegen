//
// ENUser.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENUser: ENObject {

	//MARK: - Attributes
	dynamic var displayName: String?
	dynamic var email: String?
	dynamic var firstName: String?
	dynamic var id: String = ""
	dynamic var lastName: String?
	dynamic var profileImageUrl: NSURL?
	dynamic var username: String?

	//MARK: - Relationships
	let casesCreated = List<ENCase>()
	let casesUpdated = List<ENCase>()
	dynamic var credential: ENUserCredential?
	let emsAgenciesAdministered = List<ENEMSAgency>()
	let emsAgencyMemberships = List<ENEMSAgency>()
	let hospitalsAdministrated = List<ENHospital>()
	let hospitalsMemberships = List<ENHospital>()
	let messages = List<ENChatMessage>()
	dynamic var session: ENSession?

}
