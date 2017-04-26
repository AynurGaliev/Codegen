//
// CaseQueueParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ICaseQueueParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENCaseQueue
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCaseQueue]
	var caseParser: ICaseParser! { get set }
	var aPIRequestParser: IAPIRequestParser! { get set }
}

final class CaseQueueParser: ICaseQueueParser {

	//MARK: - Dependencies
	var caseParser: ICaseParser!
	var aPIRequestParser: IAPIRequestParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENCaseQueue {

		let enCaseQueue: ENCaseQueue = ENCaseQueue()

		//MARK: - One-to-one relationships parsing
		enCaseQueue.queueCase = try self.caseParser.serialize(json: json.value(by: "queueCase"))

		return enCaseQueue
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCaseQueue] {
		guard jsonArray.count > 0 else { return [] }
		var enCaseQueues: [ENCaseQueue] = []
		for json in jsonArray {
			let enCaseQueue: ENCaseQueue = try self.serialize(json: json)
			enCaseQueues.append(enCaseQueue)
		}
		return enCaseQueues
	}

}
