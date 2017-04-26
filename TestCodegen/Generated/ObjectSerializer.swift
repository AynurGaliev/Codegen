//
// ObjectSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IObjectSerializer: class {
	func serialize(enObject: ENObject?, depth: Int) -> Object?
	func serialize(enObjects: [ENObject], depth: Int) -> [Object]
}

final class ObjectSerializer: IObjectSerializer {

	//MARK: - Dependencies

	func serialize(enObject: ENObject?, depth: Int) -> Object? {

		guard let lObject = enObject else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lObject.createdAt
		let localUpdatedAt = lObject.localUpdatedAt
		let updatedAt = lObject.updatedAt


		return Object(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	func serialize(enObjects: [ENObject], depth: Int) -> [Object] {

		guard enObjects.count != 0 else { return [] }
		var serializedObjects: [Object] = []
		for value in enObjects {
			guard let entity = self.serialize(enObject: value, depth: depth) else { continue }
			serializedObjects.append(entity)
		}
		return serializedObjects
	}
}
