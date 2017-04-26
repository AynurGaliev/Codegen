//
// HospitalParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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
