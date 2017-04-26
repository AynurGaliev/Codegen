//
// UserCredentialParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IUserCredentialParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENUserCredential
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENUserCredential]
	var userParser: IUserParser! { get set }
}

final class UserCredentialParser: IUserCredentialParser {

	//MARK: - Dependencies
	var userParser: IUserParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENUserCredential {

		let enUserCredential: ENUserCredential = ENUserCredential()

		//MARK: - Parsing attributes
		enUserCredential.expirationDate = try json.value(by: "expirationDate")
		enUserCredential.token = try json.value(by: "token")

		//MARK: - One-to-one relationships parsing
		enUserCredential.user = try self.userParser.serialize(json: json.value(by: "user"))

		return enUserCredential
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENUserCredential] {
		guard jsonArray.count > 0 else { return [] }
		var enUserCredentials: [ENUserCredential] = []
		for json in jsonArray {
			let enUserCredential: ENUserCredential = try self.serialize(json: json)
			enUserCredentials.append(enUserCredential)
		}
		return enUserCredentials
	}

}
