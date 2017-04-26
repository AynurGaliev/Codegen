//
// APIRequestTagParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestTagParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestTag
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestTag]
}

final class APIRequestTagParser: IAPIRequestTagParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestTag {

		let enAPIRequestTag: ENAPIRequestTag = ENAPIRequestTag()

		//MARK: - Parsing attributes
		enAPIRequestTag.enabled = try json.value(by: "enabled")
		enAPIRequestTag.tagID = try json.value(by: "tagID")

		return enAPIRequestTag
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestTag] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestTags: [ENAPIRequestTag] = []
		for json in jsonArray {
			let enAPIRequestTag: ENAPIRequestTag = try self.serialize(json: json)
			enAPIRequestTags.append(enAPIRequestTag)
		}
		return enAPIRequestTags
	}

}
