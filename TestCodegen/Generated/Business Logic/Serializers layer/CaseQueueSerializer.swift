//
// CaseQueueSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ICaseQueueSerializer: class {
	func serialize(enCaseQueue: ENCaseQueue?, depth: Int) -> CaseQueue?
	func serialize(enCaseQueues: [ENCaseQueue], depth: Int) -> [CaseQueue]
	var caseSerializer: ICaseSerializer! { get set }
	var aPIRequestSerializer: IAPIRequestSerializer! { get set }
}

final class CaseQueueSerializer: ICaseQueueSerializer {

	//MARK: - Dependencies
	var caseSerializer: ICaseSerializer!
	var aPIRequestSerializer: IAPIRequestSerializer!

	func serialize(enCaseQueue: ENCaseQueue?, depth: Int) -> CaseQueue? {

		guard let lCaseQueue = enCaseQueue else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)


		//MARK: - Serializing relationships
		let queueCase = self.caseSerializer.serialize(enCase: lCaseQueue.queueCase, depth: maxDepth - 1)!
		let requests = self.aPIRequestSerializer.serialize(enAPIRequests: Array(lCaseQueue.requests), depth: maxDepth - 1)

		return CaseQueue(queueCase: queueCase, requests: requests)
	}

	func serialize(enCaseQueues: [ENCaseQueue], depth: Int) -> [CaseQueue] {

		guard enCaseQueues.count != 0 else { return [] }
		var serializedCaseQueues: [CaseQueue] = []
		for value in enCaseQueues {
			guard let entity = self.serialize(enCaseQueue: value, depth: depth) else { continue }
			serializedCaseQueues.append(entity)
		}
		return serializedCaseQueues
	}
}
