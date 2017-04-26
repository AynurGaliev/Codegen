//
// UserParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IUserParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENUser
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENUser]
	var caseParser: ICaseParser! { get set }
	var userCredentialParser: IUserCredentialParser! { get set }
	var eMSAgencyParser: IEMSAgencyParser! { get set }
	var hospitalParser: IHospitalParser! { get set }
	var chatMessageParser: IChatMessageParser! { get set }
	var sessionParser: ISessionParser! { get set }
}

final class UserParser: IUserParser {

	//MARK: - Dependencies
	var caseParser: ICaseParser!
	var userCredentialParser: IUserCredentialParser!
	var eMSAgencyParser: IEMSAgencyParser!
	var hospitalParser: IHospitalParser!
	var chatMessageParser: IChatMessageParser!
	var sessionParser: ISessionParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENUser {

		let enUser: ENUser = ENUser()

		//MARK: - Parsing attributes
		enUser.displayName = try json.value(by: "displayName")
		enUser.email = try json.value(by: "email")
		enUser.firstName = try json.value(by: "firstName")
		enUser.id = try json.value(by: "id")
		enUser.lastName = try json.value(by: "lastName")
		enUser.profileImageUrl = try json.value(by: "profileImageUrl")
		enUser.username = try json.value(by: "username")

		//MARK: - One-to-one relationships parsing
		enUser.credential = try self.userCredentialParser.serialize(json: json.value(by: "credential"))
		enUser.session = try self.sessionParser.serialize(json: json.value(by: "session"))

		return enUser
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENUser] {
		guard jsonArray.count > 0 else { return [] }
		var enUsers: [ENUser] = []
		for json in jsonArray {
			let enUser: ENUser = try self.serialize(json: json)
			enUsers.append(enUser)
		}
		return enUsers
	}

}
