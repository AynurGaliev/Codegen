//
// ENUser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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

	//MARK: - One-to-one relationships
	private let credentials = LinkingObjects(fromType: ENUserCredential.self, property: "user")
	var credential: ENUserCredential? {
		return self.credentials.first
	}
	dynamic var session: ENSession?

	//MARK: - One-to-many relationships
	let casesCreated = LinkingObjects(fromType: ENCase.self, property: "createdBy")
	let casesUpdated = LinkingObjects(fromType: ENCase.self, property: "createdBy")
	let emsAgenciesAdministered =  LinkingObjects(fromType: ENEMSAgency.self, property: "administrators")
	let emsAgencyMemberships =  LinkingObjects(fromType: ENEMSAgency.self, property: "administrators")
	let hospitalsAdministrated =  LinkingObjects(fromType: ENHospital.self, property: "administrators")
	let hospitalsMemberships =  LinkingObjects(fromType: ENHospital.self, property: "administrators")
	let messages = LinkingObjects(fromType: ENChatMessage.self, property: "createdBy")

}
