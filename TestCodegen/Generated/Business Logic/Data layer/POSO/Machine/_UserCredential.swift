//
// _UserCredential.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:34.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _UserCredential {

	let expirationDate: Date
	let token: String
	let user: User?

	init(expirationDate: Date, token: String, user: User?) {
		self.expirationDate = expirationDate
		self.token = token
		self.user = user
	}

	enum Keys {
		static let expirationDate: String = "expirationDate"
		static let token: String = "token"
		static let user: String = "user"
	}
}

func ==(lhs: UserCredential, rhs: UserCredential) -> Bool {
	return lhs.expirationDate == rhs.expirationDate && lhs.token == rhs.token && lhs.user == rhs.user 
}

func ==(lhs: UserCredential?, rhs: UserCredential?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [UserCredential]?, rhs: [UserCredential]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
