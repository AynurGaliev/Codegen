//
// _File.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _File: _Object {

	let data: Data
	let deviceCreatedAt: Date
	let id: String
	let type: String
	let userCase: Case

	init(createdAt: Date, data: Data, deviceCreatedAt: Date, id: String, localUpdatedAt: Date, type: String, updatedAt: Date?, userCase: Case) {
		self.data = data
		self.deviceCreatedAt = deviceCreatedAt
		self.id = id
		self.type = type
		self.userCase = userCase
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let data: String = "data"
		static let deviceCreatedAt: String = "deviceCreatedAt"
		static let id: String = "id"
		static let type: String = "type"
		static let userCase: String = "userCase"
	}
}

func ==(lhs: File, rhs: File) -> Bool {
	return lhs.data == rhs.data && lhs.deviceCreatedAt == rhs.deviceCreatedAt && lhs.id == rhs.id && lhs.type == rhs.type && lhs.userCase == rhs.userCase 
}

func ==(lhs: File?, rhs: File?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [File]?, rhs: [File]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
