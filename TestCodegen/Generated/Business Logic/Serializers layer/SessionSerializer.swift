//
// SessionSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ISessionSerializer: class {
	func serialize(enSession: ENSession?, depth: Int) -> Session?
	func serialize(enSessions: [ENSession], depth: Int) -> [Session]
	var eMSAgencySerializer: IEMSAgencySerializer! { get set }
	var truckSerializer: ITruckSerializer! { get set }
	var userSerializer: IUserSerializer! { get set }
}

final class SessionSerializer: ISessionSerializer {

	//MARK: - Dependencies
	var eMSAgencySerializer: IEMSAgencySerializer!
	var truckSerializer: ITruckSerializer!
	var userSerializer: IUserSerializer!

	func serialize(enSession: ENSession?, depth: Int) -> Session? {

		guard let lSession = enSession else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let shiftEnds = lSession.shiftEnds

		//MARK: - Serializing relationships
		let emsAgency = self.eMSAgencySerializer.serialize(enEMSAgency: lSession.emsAgency, depth: maxDepth - 1)!
		let truck = self.truckSerializer.serialize(enTruck: lSession.truck, depth: maxDepth - 1)!
		let user = self.userSerializer.serialize(enUser: lSession.user, depth: maxDepth - 1)!

		return Session(emsAgency: emsAgency, shiftEnds: shiftEnds, truck: truck, user: user)
	}

	func serialize(enSessions: [ENSession], depth: Int) -> [Session] {

		guard enSessions.count != 0 else { return [] }
		var serializedSessions: [Session] = []
		for value in enSessions {
			guard let entity = self.serialize(enSession: value, depth: depth) else { continue }
			serializedSessions.append(entity)
		}
		return serializedSessions
	}
}
