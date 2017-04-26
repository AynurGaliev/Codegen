//
// ObjectParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IObjectParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENObject
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENObject]
}

final class ObjectParser: IObjectParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENObject {

		let enObject: ENObject = ENObject()

		//MARK: - Parsing attributes
		enObject.createdAt = try json.value(by: "createdAt")
		enObject.localUpdatedAt = try json.value(by: "localUpdatedAt")
		enObject.updatedAt = try json.value(by: "updatedAt")

		return enObject
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENObject] {
		guard jsonArray.count > 0 else { return [] }
		var enObjects: [ENObject] = []
		for json in jsonArray {
			let enObject: ENObject = try self.serialize(json: json)
			enObjects.append(enObject)
		}
		return enObjects
	}

}
