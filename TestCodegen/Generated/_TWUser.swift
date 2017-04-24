//
// _TWUser.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWUser: _TWObject {

	let displayName: String?
	let email: String?
	let firstName: String?
	let id: String
	let lastName: String?
	let profileImageUrl: NSURL?
	let username: String?
	let casesCreated: [TWCase]?
	let casesUpdated: [TWCase]?
	let credential: TWUserCredential?
	let emsAgenciesAdministered: [TWEMSAgency]?
	let emsAgencyMemberships: [TWEMSAgency]?
	let hospitalsAdministrated: [TWHospital]?
	let hospitalsMemberships: [TWHospital]?
	let messages: [TWChatMessage]?
	let session: TWSession?

	init(casesCreated: [TWCase]?, casesUpdated: [TWCase]?, createdAt: Date, credential: TWUserCredential?, displayName: String?, email: String?, emsAgenciesAdministered: [TWEMSAgency]?, emsAgencyMemberships: [TWEMSAgency]?, firstName: String?, hospitalsAdministrated: [TWHospital]?, hospitalsMemberships: [TWHospital]?, id: String, lastName: String?, localUpdatedAt: Date, messages: [TWChatMessage]?, profileImageUrl: NSURL?, session: TWSession?, updatedAt: Date?, username: String?) {
		self.casesCreated = casesCreated
		self.casesUpdated = casesUpdated
		self.credential = credential
		self.displayName = displayName
		self.email = email
		self.emsAgenciesAdministered = emsAgenciesAdministered
		self.emsAgencyMemberships = emsAgencyMemberships
		self.firstName = firstName
		self.hospitalsAdministrated = hospitalsAdministrated
		self.hospitalsMemberships = hospitalsMemberships
		self.id = id
		self.lastName = lastName
		self.messages = messages
		self.profileImageUrl = profileImageUrl
		self.session = session
		self.username = username
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let displayName: String = "displayName"
		static let email: String = "email"
		static let firstName: String = "firstName"
		static let id: String = "id"
		static let lastName: String = "lastName"
		static let profileImageUrl: String = "profileImageUrl"
		static let username: String = "username"
		static let casesCreated: String = "casesCreated"
		static let casesUpdated: String = "casesUpdated"
		static let credential: String = "credential"
		static let emsAgenciesAdministered: String = "emsAgenciesAdministered"
		static let emsAgencyMemberships: String = "emsAgencyMemberships"
		static let hospitalsAdministrated: String = "hospitalsAdministrated"
		static let hospitalsMemberships: String = "hospitalsMemberships"
		static let messages: String = "messages"
		static let session: String = "session"
	}
}

func ==(lhs: TWUser, rhs: TWUser) -> Bool {
	return lhs.displayName == rhs.displayName && lhs.email == rhs.email && lhs.firstName == rhs.firstName && lhs.id == rhs.id && lhs.lastName == rhs.lastName && lhs.profileImageUrl == rhs.profileImageUrl && lhs.username == rhs.username && lhs.casesCreated == rhs.casesCreated && lhs.casesUpdated == rhs.casesUpdated && lhs.credential == rhs.credential && lhs.emsAgenciesAdministered == rhs.emsAgenciesAdministered && lhs.emsAgencyMemberships == rhs.emsAgencyMemberships && lhs.hospitalsAdministrated == rhs.hospitalsAdministrated && lhs.hospitalsMemberships == rhs.hospitalsMemberships && lhs.messages == rhs.messages && lhs.session == rhs.session 
}

func ==(lhs: TWUser?, rhs: TWUser?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWUser]?, rhs: [TWUser]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
