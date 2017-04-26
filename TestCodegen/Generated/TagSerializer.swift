//
// TagSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ITagSerializer: class {
	func serialize(enTag: ENTag?, depth: Int) -> Tag?
	func serialize(enTags: [ENTag], depth: Int) -> [Tag]
	var caseSerializer: ICaseSerializer! { get set }
	var complaintSerializer: IComplaintSerializer! { get set }
}

final class TagSerializer: ITagSerializer {

	//MARK: - Dependencies
	var caseSerializer: ICaseSerializer!
	var complaintSerializer: IComplaintSerializer!

	func serialize(enTag: ENTag?, depth: Int) -> Tag? {

		guard let lTag = enTag else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lTag.createdAt
		let groupIdentifier = lTag.groupIdentifier
		let id = lTag.id
		let isSelected = lTag.isSelected
		let localUpdatedAt = lTag.localUpdatedAt
		let name = lTag.name
		let typeIdentifier = lTag.typeIdentifier
		let updatedAt = lTag.updatedAt

		//MARK: - Serializing relationships
		let cases = self.caseSerializer.serialize(enCases: Array(lTag.cases), depth: maxDepth - 1)
		let complaints = self.complaintSerializer.serialize(enComplaints: Array(lTag.complaints), depth: maxDepth - 1)

		return Tag(cases: cases, complaints: complaints, createdAt: createdAt, groupIdentifier: groupIdentifier, id: id, isSelected: isSelected, localUpdatedAt: localUpdatedAt, name: name, typeIdentifier: typeIdentifier, updatedAt: updatedAt)
	}

	func serialize(enTags: [ENTag], depth: Int) -> [Tag] {

		guard enTags.count != 0 else { return [] }
		var serializedTags: [Tag] = []
		for value in enTags {
			guard let entity = self.serialize(enTag: value, depth: depth) else { continue }
			serializedTags.append(entity)
		}
		return serializedTags
	}
}
