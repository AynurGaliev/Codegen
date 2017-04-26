//
// UserSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IUserSerializer: class {
	func serialize(enUser: ENUser?, depth: Int) -> User?
	func serialize(enUsers: [ENUser], depth: Int) -> [User]
	var caseSerializer: ICaseSerializer! { get set }
	var userCredentialSerializer: IUserCredentialSerializer! { get set }
	var eMSAgencySerializer: IEMSAgencySerializer! { get set }
	var hospitalSerializer: IHospitalSerializer! { get set }
	var chatMessageSerializer: IChatMessageSerializer! { get set }
	var sessionSerializer: ISessionSerializer! { get set }
}

final class UserSerializer: IUserSerializer {

	//MARK: - Dependencies
	var caseSerializer: ICaseSerializer!
	var userCredentialSerializer: IUserCredentialSerializer!
	var eMSAgencySerializer: IEMSAgencySerializer!
	var hospitalSerializer: IHospitalSerializer!
	var chatMessageSerializer: IChatMessageSerializer!
	var sessionSerializer: ISessionSerializer!

	func serialize(enUser: ENUser?, depth: Int) -> User? {

		guard let lUser = enUser else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lUser.createdAt
		let displayName = lUser.displayName
		let email = lUser.email
		let firstName = lUser.firstName
		let id = lUser.id
		let lastName = lUser.lastName
		let localUpdatedAt = lUser.localUpdatedAt
		let profileImageUrl = lUser.profileImageUrl
		let updatedAt = lUser.updatedAt
		let username = lUser.username

		//MARK: - Serializing relationships
		let casesCreated = self.caseSerializer.serialize(enCases: Array(lUser.casesCreated), depth: maxDepth - 1)
		let casesUpdated = self.caseSerializer.serialize(enCases: Array(lUser.casesUpdated), depth: maxDepth - 1)
		let credential = self.userCredentialSerializer.serialize(enUserCredential: lUser.credential, depth: maxDepth - 1)
		let emsAgenciesAdministered = self.eMSAgencySerializer.serialize(enEMSAgencys: Array(lUser.emsAgenciesAdministered), depth: maxDepth - 1)
		let emsAgencyMemberships = self.eMSAgencySerializer.serialize(enEMSAgencys: Array(lUser.emsAgencyMemberships), depth: maxDepth - 1)
		let hospitalsAdministrated = self.hospitalSerializer.serialize(enHospitals: Array(lUser.hospitalsAdministrated), depth: maxDepth - 1)
		let hospitalsMemberships = self.hospitalSerializer.serialize(enHospitals: Array(lUser.hospitalsMemberships), depth: maxDepth - 1)
		let messages = self.chatMessageSerializer.serialize(enChatMessages: Array(lUser.messages), depth: maxDepth - 1)
		let session = self.sessionSerializer.serialize(enSession: lUser.session, depth: maxDepth - 1)

		return User(casesCreated: casesCreated, casesUpdated: casesUpdated, createdAt: createdAt, credential: credential, displayName: displayName, email: email, emsAgenciesAdministered: emsAgenciesAdministered, emsAgencyMemberships: emsAgencyMemberships, firstName: firstName, hospitalsAdministrated: hospitalsAdministrated, hospitalsMemberships: hospitalsMemberships, id: id, lastName: lastName, localUpdatedAt: localUpdatedAt, messages: messages, profileImageUrl: profileImageUrl, session: session, updatedAt: updatedAt, username: username)
	}

	func serialize(enUsers: [ENUser], depth: Int) -> [User] {

		guard enUsers.count != 0 else { return [] }
		var serializedUsers: [User] = []
		for value in enUsers {
			guard let entity = self.serialize(enUser: value, depth: depth) else { continue }
			serializedUsers.append(entity)
		}
		return serializedUsers
	}
}
