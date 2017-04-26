//
// HospitalParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IHospitalParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENHospital
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENHospital]
	var userParser: IUserParser! { get set }
	var caseParser: ICaseParser! { get set }
	var eMSAgencyParser: IEMSAgencyParser! { get set }
}

final class HospitalParser: IHospitalParser {

	//MARK: - Dependencies
	var userParser: IUserParser!
	var caseParser: ICaseParser!
	var eMSAgencyParser: IEMSAgencyParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENHospital {

		let enHospital: ENHospital = ENHospital()

		//MARK: - Parsing attributes
		enHospital.id = try json.value(by: "id")
		enHospital.location = try json.value(by: "location")
		enHospital.name = try json.value(by: "name")

		//MARK: - One-to-many relationships parsing
		let _cases = try self.caseParser.serialize(jsonArray: json.value(by: "cases"))
		_cases.forEach { enHospital.cases.append($0) }

		//MARK: - Many-to-many relationships parsing
		let _administrators = try self.userParser.serialize(jsonArray: json.value(by: "administrators"))
		_administrators.forEach { $0.hospitalsAdministrated.append(enHospital) }
		let _emsAgencies = try self.eMSAgencyParser.serialize(jsonArray: json.value(by: "emsAgencies"))
		_emsAgencies.forEach { enHospital.emsAgencies.append($0) }
		let _members = try self.userParser.serialize(jsonArray: json.value(by: "members"))
		_members.forEach { $0.hospitalsAdministrated.append(enHospital) }

		return enHospital
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENHospital] {
		guard jsonArray.count > 0 else { return [] }
		var enHospitals: [ENHospital] = []
		for json in jsonArray {
			let enHospital: ENHospital = try self.serialize(json: json)
			enHospitals.append(enHospital)
		}
		return enHospitals
	}

}
