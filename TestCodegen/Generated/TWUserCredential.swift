//
// TWUserCredential.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWUserCredential {

	let expirationDate: Date
	let token: String
	let user: TWUser?

	init(expirationDate: Date, token: String, user: TWUser?) {
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

func ==(lhs: TWUserCredential, rhs: TWUserCredential) -> Bool {
	return lhs.expirationDate == rhs.expirationDate && lhs.token == rhs.token && lhs.user == rhs.user 
}

func ==(lhs: TWUserCredential?, rhs: TWUserCredential?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWUserCredential]?, rhs: [TWUserCredential]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
