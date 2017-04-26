//
// TruckSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ITruckSerializer: class {
	func serialize(enTruck: ENTruck?, depth: Int) -> Truck?
	func serialize(enTrucks: [ENTruck], depth: Int) -> [Truck]
	var eMSAgencySerializer: IEMSAgencySerializer! { get set }
	var caseSerializer: ICaseSerializer! { get set }
	var sessionSerializer: ISessionSerializer! { get set }
}

final class TruckSerializer: ITruckSerializer {

	//MARK: - Dependencies
	var eMSAgencySerializer: IEMSAgencySerializer!
	var caseSerializer: ICaseSerializer!
	var sessionSerializer: ISessionSerializer!

	func serialize(enTruck: ENTruck?, depth: Int) -> Truck? {

		guard let lTruck = enTruck else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lTruck.createdAt
		let id = lTruck.id
		let isALS = lTruck.isALS
		let localUpdatedAt = lTruck.localUpdatedAt
		let name = lTruck.name
		let updatedAt = lTruck.updatedAt

		//MARK: - Serializing relationships
		let agencies = self.eMSAgencySerializer.serialize(enEMSAgencys: Array(lTruck.agencies), depth: maxDepth - 1)
		let cases = self.caseSerializer.serialize(enCases: Array(lTruck.cases), depth: maxDepth - 1)
		let session = self.sessionSerializer.serialize(enSession: lTruck.session, depth: maxDepth - 1)

		return Truck(agencies: agencies, cases: cases, createdAt: createdAt, id: id, isALS: isALS, localUpdatedAt: localUpdatedAt, name: name, session: session, updatedAt: updatedAt)
	}

	func serialize(enTrucks: [ENTruck], depth: Int) -> [Truck] {

		guard enTrucks.count != 0 else { return [] }
		var serializedTrucks: [Truck] = []
		for value in enTrucks {
			guard let entity = self.serialize(enTruck: value, depth: depth) else { continue }
			serializedTrucks.append(entity)
		}
		return serializedTrucks
	}
}
