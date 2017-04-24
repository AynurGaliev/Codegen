//
// ENTWUser.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWUser: ENTWObject {

	//MARK: - Attributes
	dynamic var displayName: String?
	dynamic var email: String?
	dynamic var firstName: String?
	dynamic var id: String = ""
	dynamic var lastName: String?
	dynamic var profileImageUrl: NSURL?
	dynamic var username: String?

	//MARK: - One-to-one relationships
	dynamic var credential: ENTWUserCredential?
	dynamic var session: ENTWSession?

	//MARK: - One-to-many relationships
	let casesCreated = List<ENTWCase>()
	let casesUpdated = List<ENTWCase>()
	let emsAgenciesAdministered = List<ENTWEMSAgency>()
	let emsAgencyMemberships = List<ENTWEMSAgency>()
	let hospitalsAdministrated = List<ENTWHospital>()
	let hospitalsMemberships = List<ENTWHospital>()
	let messages = List<ENTWChatMessage>()

}
