//
// _User.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _User: _Object {

	let displayName: String?
	let email: String?
	let firstName: String?
	let id: String
	let lastName: String?
	let profileImageUrl: NSURL?
	let username: String?
	let casesCreated: [Case]?
	let casesUpdated: [Case]?
	let credential: UserCredential?
	let emsAgenciesAdministered: [EMSAgency]?
	let emsAgencyMemberships: [EMSAgency]?
	let hospitalsAdministrated: [Hospital]?
	let hospitalsMemberships: [Hospital]?
	let messages: [ChatMessage]?
	let session: Session?

	init(casesCreated: [Case]?, casesUpdated: [Case]?, createdAt: Date, credential: UserCredential?, displayName: String?, email: String?, emsAgenciesAdministered: [EMSAgency]?, emsAgencyMemberships: [EMSAgency]?, firstName: String?, hospitalsAdministrated: [Hospital]?, hospitalsMemberships: [Hospital]?, id: String, lastName: String?, localUpdatedAt: Date, messages: [ChatMessage]?, profileImageUrl: NSURL?, session: Session?, updatedAt: Date?, username: String?) {
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

func ==(lhs: User, rhs: User) -> Bool {
	return lhs.displayName == rhs.displayName && lhs.email == rhs.email && lhs.firstName == rhs.firstName && lhs.id == rhs.id && lhs.lastName == rhs.lastName && lhs.profileImageUrl == rhs.profileImageUrl && lhs.username == rhs.username && lhs.casesCreated == rhs.casesCreated && lhs.casesUpdated == rhs.casesUpdated && lhs.credential == rhs.credential && lhs.emsAgenciesAdministered == rhs.emsAgenciesAdministered && lhs.emsAgencyMemberships == rhs.emsAgencyMemberships && lhs.hospitalsAdministrated == rhs.hospitalsAdministrated && lhs.hospitalsMemberships == rhs.hospitalsMemberships && lhs.messages == rhs.messages && lhs.session == rhs.session 
}

func ==(lhs: User?, rhs: User?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [User]?, rhs: [User]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
