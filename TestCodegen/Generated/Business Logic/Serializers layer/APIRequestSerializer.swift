//
// APIRequestSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestSerializer: class {
	func serialize(enAPIRequest: ENAPIRequest?, depth: Int) -> APIRequest?
	func serialize(enAPIRequests: [ENAPIRequest], depth: Int) -> [APIRequest]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestSerializer: IAPIRequestSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequest: ENAPIRequest?, depth: Int) -> APIRequest? {

		guard let lAPIRequest = enAPIRequest else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let isRequired = lAPIRequest.isRequired

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequest.queue, depth: maxDepth - 1)

		return APIRequest(isRequired: isRequired, queue: queue)
	}

	func serialize(enAPIRequests: [ENAPIRequest], depth: Int) -> [APIRequest] {

		guard enAPIRequests.count != 0 else { return [] }
		var serializedAPIRequests: [APIRequest] = []
		for value in enAPIRequests {
			guard let entity = self.serialize(enAPIRequest: value, depth: depth) else { continue }
			serializedAPIRequests.append(entity)
		}
		return serializedAPIRequests
	}
}
