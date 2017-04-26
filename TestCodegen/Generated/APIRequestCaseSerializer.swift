//
// APIRequestCaseSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestCaseSerializer: class {
	func serialize(enAPIRequestCase: ENAPIRequestCase?, depth: Int) -> APIRequestCase?
	func serialize(enAPIRequestCases: [ENAPIRequestCase], depth: Int) -> [APIRequestCase]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestCaseSerializer: IAPIRequestCaseSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestCase: ENAPIRequestCase?, depth: Int) -> APIRequestCase? {

		guard let lAPIRequestCase = enAPIRequestCase else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let isRequired = lAPIRequestCase.isRequired
		let parameters = lAPIRequestCase.parameters

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestCase.queue, depth: maxDepth - 1)

		return APIRequestCase(isRequired: isRequired, parameters: parameters, queue: queue)
	}

	func serialize(enAPIRequestCases: [ENAPIRequestCase], depth: Int) -> [APIRequestCase] {

		guard enAPIRequestCases.count != 0 else { return [] }
		var serializedAPIRequestCases: [APIRequestCase] = []
		for value in enAPIRequestCases {
			guard let entity = self.serialize(enAPIRequestCase: value, depth: depth) else { continue }
			serializedAPIRequestCases.append(entity)
		}
		return serializedAPIRequestCases
	}
}
