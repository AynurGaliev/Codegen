//
// _Object.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Object {

	let createdAt: Date
	let localUpdatedAt: Date
	let updatedAt: Date?

	init(createdAt: Date, localUpdatedAt: Date, updatedAt: Date?) {
		self.createdAt = createdAt
		self.localUpdatedAt = localUpdatedAt
		self.updatedAt = updatedAt
	}

	enum Keys {
		static let createdAt: String = "createdAt"
		static let localUpdatedAt: String = "localUpdatedAt"
		static let updatedAt: String = "updatedAt"
	}
}

func ==(lhs: Object, rhs: Object) -> Bool {
	return lhs.createdAt == rhs.createdAt && lhs.localUpdatedAt == rhs.localUpdatedAt && lhs.updatedAt == rhs.updatedAt 
}

func ==(lhs: Object?, rhs: Object?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Object]?, rhs: [Object]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
