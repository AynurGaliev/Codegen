//
// UserCredentialSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IUserCredentialSerializer: class {
	func serialize(enUserCredential: ENUserCredential?, depth: Int) -> UserCredential?
	func serialize(enUserCredentials: [ENUserCredential], depth: Int) -> [UserCredential]
	var userSerializer: IUserSerializer! { get set }
}

final class UserCredentialSerializer: IUserCredentialSerializer {

	//MARK: - Dependencies
	var userSerializer: IUserSerializer!

	func serialize(enUserCredential: ENUserCredential?, depth: Int) -> UserCredential? {

		guard let lUserCredential = enUserCredential else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let expirationDate = lUserCredential.expirationDate
		let token = lUserCredential.token

		//MARK: - Serializing relationships
		let user = self.userSerializer.serialize(enUser: lUserCredential.user, depth: maxDepth - 1)

		return UserCredential(expirationDate: expirationDate, token: token, user: user)
	}

	func serialize(enUserCredentials: [ENUserCredential], depth: Int) -> [UserCredential] {

		guard enUserCredentials.count != 0 else { return [] }
		var serializedUserCredentials: [UserCredential] = []
		for value in enUserCredentials {
			guard let entity = self.serialize(enUserCredential: value, depth: depth) else { continue }
			serializedUserCredentials.append(entity)
		}
		return serializedUserCredentials
	}
}
