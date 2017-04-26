//
// CaseParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ICaseParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENCase
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCase]
	var complaintParser: IComplaintParser! { get set }
	var userParser: IUserParser! { get set }
	var hospitalParser: IHospitalParser! { get set }
	var eMSAgencyParser: IEMSAgencyParser! { get set }
	var fileParser: IFileParser! { get set }
	var chatMessageParser: IChatMessageParser! { get set }
	var caseQueueParser: ICaseQueueParser! { get set }
	var tagParser: ITagParser! { get set }
	var truckParser: ITruckParser! { get set }
}

final class CaseParser: ICaseParser {

	//MARK: - Dependencies
	var complaintParser: IComplaintParser!
	var userParser: IUserParser!
	var hospitalParser: IHospitalParser!
	var eMSAgencyParser: IEMSAgencyParser!
	var fileParser: IFileParser!
	var chatMessageParser: IChatMessageParser!
	var caseQueueParser: ICaseQueueParser!
	var tagParser: ITagParser!
	var truckParser: ITruckParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENCase {

		let enCase: ENCase = ENCase()

		//MARK: - Parsing attributes
		enCase.age.value = try json.value(by: "age")
		enCase.agePeriod.value = try json.value(by: "agePeriod")
		enCase.arrivedAt = try json.value(by: "arrivedAt")
		enCase.beganAt = try json.value(by: "beganAt")
		enCase.caseNumber.value = try json.value(by: "caseNumber")
		enCase.channelId = try json.value(by: "channelId")
		enCase.closedAt = try json.value(by: "closedAt")
		enCase.gender = try json.value(by: "gender")
		enCase.id = try json.value(by: "id")

		//MARK: - One-to-one relationships parsing
		enCase.complaint = try self.complaintParser.serialize(json: json.value(by: "complaint"))
		enCase.createdBy = try self.userParser.serialize(json: json.value(by: "createdBy"))
		enCase.destinationHospital = try self.hospitalParser.serialize(json: json.value(by: "destinationHospital"))
		enCase.emsAgency = try self.eMSAgencyParser.serialize(json: json.value(by: "emsAgency"))
		enCase.queue = try self.caseQueueParser.serialize(json: json.value(by: "queue"))
		enCase.truck = try self.truckParser.serialize(json: json.value(by: "truck"))
		enCase.updatedBy = try self.userParser.serialize(json: json.value(by: "updatedBy"))

		return enCase
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCase] {
		guard jsonArray.count > 0 else { return [] }
		var enCases: [ENCase] = []
		for json in jsonArray {
			let enCase: ENCase = try self.serialize(json: json)
			enCases.append(enCase)
		}
		return enCases
	}

}
