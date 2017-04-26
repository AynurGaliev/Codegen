//
// APIRequestCaseParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestCaseParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestCase
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestCase]
}

final class APIRequestCaseParser: IAPIRequestCaseParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestCase {

		let enAPIRequestCase: ENAPIRequestCase = ENAPIRequestCase()

		//MARK: - Parsing attributes
		enAPIRequestCase.parameters = try json.value(by: "parameters")

		return enAPIRequestCase
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestCase] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestCases: [ENAPIRequestCase] = []
		for json in jsonArray {
			let enAPIRequestCase: ENAPIRequestCase = try self.serialize(json: json)
			enAPIRequestCases.append(enAPIRequestCase)
		}
		return enAPIRequestCases
	}

}
