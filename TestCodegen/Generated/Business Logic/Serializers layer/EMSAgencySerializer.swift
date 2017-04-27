//
// EMSAgencySerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IEMSAgencySerializer: class {
	func serialize(enEMSAgency: ENEMSAgency?, depth: Int) -> EMSAgency?
	func serialize(enEMSAgencys: [ENEMSAgency], depth: Int) -> [EMSAgency]
	var userSerializer: IUserSerializer! { get set }
	var caseSerializer: ICaseSerializer! { get set }
	var hospitalSerializer: IHospitalSerializer! { get set }
	var sessionSerializer: ISessionSerializer! { get set }
	var truckSerializer: ITruckSerializer! { get set }
}

final class EMSAgencySerializer: IEMSAgencySerializer {

	//MARK: - Dependencies
	var userSerializer: IUserSerializer!
	var caseSerializer: ICaseSerializer!
	var hospitalSerializer: IHospitalSerializer!
	var sessionSerializer: ISessionSerializer!
	var truckSerializer: ITruckSerializer!

	func serialize(enEMSAgency: ENEMSAgency?, depth: Int) -> EMSAgency? {

		guard let lEMSAgency = enEMSAgency else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let complaintSet = lEMSAgency.complaintSet
		let createdAt = lEMSAgency.createdAt
		let id = lEMSAgency.id
		let localUpdatedAt = lEMSAgency.localUpdatedAt
		let maxCaseLength = lEMSAgency.maxCaseLength.value
		let name = lEMSAgency.name
		let updatedAt = lEMSAgency.updatedAt

		//MARK: - Serializing relationships
		let administrators = self.userSerializer.serialize(enUsers: Array(lEMSAgency.administrators), depth: maxDepth - 1)
		let cases = self.caseSerializer.serialize(enCases: Array(lEMSAgency.cases), depth: maxDepth - 1)
		let hospitals = self.hospitalSerializer.serialize(enHospitals: Array(lEMSAgency.hospitals), depth: maxDepth - 1)
		let members = self.userSerializer.serialize(enUsers: Array(lEMSAgency.members), depth: maxDepth - 1)
		let session = self.sessionSerializer.serialize(enSession: lEMSAgency.session, depth: maxDepth - 1)
		let trucks = self.truckSerializer.serialize(enTrucks: Array(lEMSAgency.trucks), depth: maxDepth - 1)

		return EMSAgency(administrators: administrators, cases: cases, complaintSet: complaintSet, createdAt: createdAt, hospitals: hospitals, id: id, localUpdatedAt: localUpdatedAt, maxCaseLength: maxCaseLength, members: members, name: name, session: session, trucks: trucks, updatedAt: updatedAt)
	}

	func serialize(enEMSAgencys: [ENEMSAgency], depth: Int) -> [EMSAgency] {

		guard enEMSAgencys.count != 0 else { return [] }
		var serializedEMSAgencys: [EMSAgency] = []
		for value in enEMSAgencys {
			guard let entity = self.serialize(enEMSAgency: value, depth: depth) else { continue }
			serializedEMSAgencys.append(entity)
		}
		return serializedEMSAgencys
	}
}
