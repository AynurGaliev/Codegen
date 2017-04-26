//
// EMSAgencyParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IEMSAgencyParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENEMSAgency
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENEMSAgency]
	var userParser: IUserParser! { get set }
	var caseParser: ICaseParser! { get set }
	var hospitalParser: IHospitalParser! { get set }
	var sessionParser: ISessionParser! { get set }
	var truckParser: ITruckParser! { get set }
}

final class EMSAgencyParser: IEMSAgencyParser {

	//MARK: - Dependencies
	var userParser: IUserParser!
	var caseParser: ICaseParser!
	var hospitalParser: IHospitalParser!
	var sessionParser: ISessionParser!
	var truckParser: ITruckParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENEMSAgency {

		let enEMSAgency: ENEMSAgency = ENEMSAgency()

		//MARK: - Parsing attributes
		enEMSAgency.complaintSet = try json.value(by: "complaintSet")
		enEMSAgency.id = try json.value(by: "id")
		enEMSAgency.maxCaseLength.value = try json.value(by: "maxCaseLength")
		enEMSAgency.name = try json.value(by: "name")

		//MARK: - One-to-one relationships parsing
		enEMSAgency.session = try self.sessionParser.serialize(json: json.value(by: "session"))

		return enEMSAgency
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENEMSAgency] {
		guard jsonArray.count > 0 else { return [] }
		var enEMSAgencys: [ENEMSAgency] = []
		for json in jsonArray {
			let enEMSAgency: ENEMSAgency = try self.serialize(json: json)
			enEMSAgencys.append(enEMSAgency)
		}
		return enEMSAgencys
	}

}
