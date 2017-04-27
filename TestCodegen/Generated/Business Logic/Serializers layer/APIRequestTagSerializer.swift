//
// APIRequestTagSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestTagSerializer: class {
	func serialize(enAPIRequestTag: ENAPIRequestTag?, depth: Int) -> APIRequestTag?
	func serialize(enAPIRequestTags: [ENAPIRequestTag], depth: Int) -> [APIRequestTag]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestTagSerializer: IAPIRequestTagSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestTag: ENAPIRequestTag?, depth: Int) -> APIRequestTag? {

		guard let lAPIRequestTag = enAPIRequestTag else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let enabled = lAPIRequestTag.enabled
		let isRequired = lAPIRequestTag.isRequired
		let tagID = lAPIRequestTag.tagID

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestTag.queue, depth: maxDepth - 1)

		return APIRequestTag(enabled: enabled, isRequired: isRequired, queue: queue, tagID: tagID)
	}

	func serialize(enAPIRequestTags: [ENAPIRequestTag], depth: Int) -> [APIRequestTag] {

		guard enAPIRequestTags.count != 0 else { return [] }
		var serializedAPIRequestTags: [APIRequestTag] = []
		for value in enAPIRequestTags {
			guard let entity = self.serialize(enAPIRequestTag: value, depth: depth) else { continue }
			serializedAPIRequestTags.append(entity)
		}
		return serializedAPIRequestTags
	}
}
