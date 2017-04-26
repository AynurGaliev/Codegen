//
// TruckParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ITruckParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENTruck
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENTruck]
	var eMSAgencyParser: IEMSAgencyParser! { get set }
	var caseParser: ICaseParser! { get set }
	var sessionParser: ISessionParser! { get set }
}

final class TruckParser: ITruckParser {

	//MARK: - Dependencies
	var eMSAgencyParser: IEMSAgencyParser!
	var caseParser: ICaseParser!
	var sessionParser: ISessionParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENTruck {

		let enTruck: ENTruck = ENTruck()

		//MARK: - Parsing attributes
		enTruck.id = try json.value(by: "id")
		enTruck.isALS = try json.value(by: "isALS")
		enTruck.name = try json.value(by: "name")

		//MARK: - One-to-one relationships parsing
		enTruck.session = try self.sessionParser.serialize(json: json.value(by: "session"))

		//MARK: - One-to-many relationships parsing
		let _cases = try self.caseParser.serialize(jsonArray: json.value(by: "cases"))
		_cases.forEach { enTruck.cases.append($0) }

		//MARK: - Many-to-many relationships parsing
		let _agencies = try self.eMSAgencyParser.serialize(jsonArray: json.value(by: "agencies"))
		_agencies.forEach { enTruck.agencies.append($0) }

		return enTruck
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENTruck] {
		guard jsonArray.count > 0 else { return [] }
		var enTrucks: [ENTruck] = []
		for json in jsonArray {
			let enTruck: ENTruck = try self.serialize(json: json)
			enTrucks.append(enTruck)
		}
		return enTrucks
	}

}
