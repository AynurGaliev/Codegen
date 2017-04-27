//
// APIRequestParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequest
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequest]
	var caseQueueParser: ICaseQueueParser! { get set }
}

final class APIRequestParser: IAPIRequestParser {

	//MARK: - Dependencies
	var caseQueueParser: ICaseQueueParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequest {

		let enAPIRequest: ENAPIRequest = ENAPIRequest()

		//MARK: - Parsing attributes
		enAPIRequest.isRequired = try json.value(by: "isRequired")

		//MARK: - One-to-one relationships parsing
		let _queue = try self.caseQueueParser.serialize(json: json.value(by: "queue"))
		_queue.requests.append(enAPIRequest)

		return enAPIRequest
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequest] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequests: [ENAPIRequest] = []
		for json in jsonArray {
			let enAPIRequest: ENAPIRequest = try self.serialize(json: json)
			enAPIRequests.append(enAPIRequest)
		}
		return enAPIRequests
	}

}
