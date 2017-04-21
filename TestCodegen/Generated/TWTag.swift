//
// TWTag.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWTag: TWObject {

	let groupIdentifier: String
	let id: String
	let isSelected: Bool
	let name: String
	let typeIdentifier: String
	let cases: [TWCase]?
	let complaints: [TWComplaint]?

	init(cases: [TWCase]?, complaints: [TWComplaint]?, createdAt: Date, groupIdentifier: String, id: String, isSelected: Bool, localUpdatedAt: Date, name: String, typeIdentifier: String, updatedAt: Date?) {
		self.cases = cases
		self.complaints = complaints
		self.groupIdentifier = groupIdentifier
		self.id = id
		self.isSelected = isSelected
		self.name = name
		self.typeIdentifier = typeIdentifier
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let groupIdentifier: String = "groupIdentifier"
		static let id: String = "id"
		static let isSelected: String = "isSelected"
		static let name: String = "name"
		static let typeIdentifier: String = "typeIdentifier"
		static let cases: String = "cases"
		static let complaints: String = "complaints"
	}
}

func ==(lhs: TWTag, rhs: TWTag) -> Bool {
	return lhs.groupIdentifier == rhs.groupIdentifier && lhs.id == rhs.id && lhs.isSelected == rhs.isSelected && lhs.name == rhs.name && lhs.typeIdentifier == rhs.typeIdentifier && lhs.cases == rhs.cases && lhs.complaints == rhs.complaints 
}

func ==(lhs: TWTag?, rhs: TWTag?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWTag]?, rhs: [TWTag]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
