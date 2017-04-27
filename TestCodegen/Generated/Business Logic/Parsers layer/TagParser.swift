//
// TagParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ITagParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENTag
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENTag]
	var caseParser: ICaseParser! { get set }
	var complaintParser: IComplaintParser! { get set }
}

final class TagParser: ITagParser {

	//MARK: - Dependencies
	var caseParser: ICaseParser!
	var complaintParser: IComplaintParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENTag {

		let enTag: ENTag = ENTag()

		//MARK: - Parsing attributes
		enTag.groupIdentifier = try json.value(by: "groupIdentifier")
		enTag.id = try json.value(by: "id")
		enTag.isSelected = try json.value(by: "isSelected")
		enTag.name = try json.value(by: "name")
		enTag.typeIdentifier = try json.value(by: "typeIdentifier")

		//MARK: - Many-to-many relationships parsing
		let _cases = try self.caseParser.serialize(jsonArray: json.value(by: "cases"))
		_cases.forEach { enTag.cases.append($0) }
		let _complaints = try self.complaintParser.serialize(jsonArray: json.value(by: "complaints"))
		_complaints.forEach { enTag.complaints.append($0) }

		return enTag
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENTag] {
		guard jsonArray.count > 0 else { return [] }
		var enTags: [ENTag] = []
		for json in jsonArray {
			let enTag: ENTag = try self.serialize(json: json)
			enTags.append(enTag)
		}
		return enTags
	}

}
