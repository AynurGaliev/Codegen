//
// SessionParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ISessionParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENSession
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENSession]
	var eMSAgencyParser: IEMSAgencyParser! { get set }
	var truckParser: ITruckParser! { get set }
	var userParser: IUserParser! { get set }
}

final class SessionParser: ISessionParser {

	//MARK: - Dependencies
	var eMSAgencyParser: IEMSAgencyParser!
	var truckParser: ITruckParser!
	var userParser: IUserParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENSession {

		let enSession: ENSession = ENSession()

		//MARK: - Parsing attributes
		enSession.shiftEnds = try json.value(by: "shiftEnds")

		//MARK: - One-to-one relationships parsing
		enSession.emsAgency = try self.eMSAgencyParser.serialize(json: json.value(by: "emsAgency"))
		let _truck = try self.truckParser.serialize(json: json.value(by: "truck"))
		_truck.session = enSession
		let _user = try self.userParser.serialize(json: json.value(by: "user"))
		_user.session = enSession

		return enSession
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENSession] {
		guard jsonArray.count > 0 else { return [] }
		var enSessions: [ENSession] = []
		for json in jsonArray {
			let enSession: ENSession = try self.serialize(json: json)
			enSessions.append(enSession)
		}
		return enSessions
	}

}
