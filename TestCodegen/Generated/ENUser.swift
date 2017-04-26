//
// ENUser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
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
	dynamic var profileImageUrl: Data?
	dynamic var username: String?

	//MARK: - One-to-one relationships
	private let credentials = LinkingObjects(fromType: ENUserCredential.self, property: "user")
	var credential: ENUserCredential? {
		return self.credentials.first
	}
	dynamic var session: ENSession?

	//MARK: - One-to-many relationships
	let casesCreated = List<ENCase>()
	let casesUpdated = List<ENCase>()
	let messages = List<ENChatMessage>()

	//MARK: - Many-to-many relationships
	let emsAgenciesAdministered = List<ENEMSAgency>()
	let emsAgencyMemberships = List<ENEMSAgency>()
	let hospitalsAdministrated = List<ENHospital>()
	let hospitalsMemberships = List<ENHospital>()

}
