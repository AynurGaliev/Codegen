//
// HospitalSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IHospitalSerializer: class {
	func serialize(enHospital: ENHospital?, depth: Int) -> Hospital?
	func serialize(enHospitals: [ENHospital], depth: Int) -> [Hospital]
	var userSerializer: IUserSerializer! { get set }
	var caseSerializer: ICaseSerializer! { get set }
	var eMSAgencySerializer: IEMSAgencySerializer! { get set }
}

final class HospitalSerializer: IHospitalSerializer {

	//MARK: - Dependencies
	var userSerializer: IUserSerializer!
	var caseSerializer: ICaseSerializer!
	var eMSAgencySerializer: IEMSAgencySerializer!

	func serialize(enHospital: ENHospital?, depth: Int) -> Hospital? {

		guard let lHospital = enHospital else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lHospital.createdAt
		let id = lHospital.id
		let localUpdatedAt = lHospital.localUpdatedAt
		let location = lHospital.location
		let name = lHospital.name
		let updatedAt = lHospital.updatedAt

		//MARK: - Serializing relationships
		let administrators = self.userSerializer.serialize(enUsers: Array(lHospital.administrators), depth: maxDepth - 1)
		let cases = self.caseSerializer.serialize(enCases: Array(lHospital.cases), depth: maxDepth - 1)
		let emsAgencies = self.eMSAgencySerializer.serialize(enEMSAgencys: Array(lHospital.emsAgencies), depth: maxDepth - 1)
		let members = self.userSerializer.serialize(enUsers: Array(lHospital.members), depth: maxDepth - 1)

		return Hospital(administrators: administrators, cases: cases, createdAt: createdAt, emsAgencies: emsAgencies, id: id, localUpdatedAt: localUpdatedAt, location: location, members: members, name: name, updatedAt: updatedAt)
	}

	func serialize(enHospitals: [ENHospital], depth: Int) -> [Hospital] {

		guard enHospitals.count != 0 else { return [] }
		var serializedHospitals: [Hospital] = []
		for value in enHospitals {
			guard let entity = self.serialize(enHospital: value, depth: depth) else { continue }
			serializedHospitals.append(entity)
		}
		return serializedHospitals
	}
}
