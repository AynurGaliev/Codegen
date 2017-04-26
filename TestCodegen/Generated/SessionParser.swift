//
// SessionParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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
		enSession.truck = try self.truckParser.serialize(json: json.value(by: "truck"))
		enSession.user = try self.userParser.serialize(json: json.value(by: "user"))

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
