//
// ENCase.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENCase: ENObject {

	//MARK: - Attributes
	let age = RealmOptional<Int>()
	let agePeriod = RealmOptional<Int>()
	dynamic var arrivedAt: Date?
	dynamic var beganAt: Date?
	let caseNumber = RealmOptional<Int>()
	dynamic var channelId: String?
	dynamic var closedAt: Date?
	dynamic var gender: String?
	dynamic var id: String = ""

	//MARK: - One-to-one relationships
	private let complaints = LinkingObjects(fromType: ENComplaint.self, property: "cases")
	var complaint: ENComplaint? {
		return self.complaints.first
	}
	private let createdBys = LinkingObjects(fromType: ENUser.self, property: "casesCreated")
	var createdBy: ENUser? {
		return self.createdBys.first
	}
	private let destinationHospitals = LinkingObjects(fromType: ENHospital.self, property: "cases")
	var destinationHospital: ENHospital? {
		return self.destinationHospitals.first
	}
	private let emsAgencys = LinkingObjects(fromType: ENEMSAgency.self, property: "cases")
	var emsAgency: ENEMSAgency? {
		return self.emsAgencys.first
	}
	private let queues = LinkingObjects(fromType: ENCaseQueue.self, property: "queueCase")
	var queue: ENCaseQueue? {
		return self.queues.first
	}
	private let trucks = LinkingObjects(fromType: ENTruck.self, property: "cases")
	var truck: ENTruck? {
		return self.trucks.first
	}
	private let updatedBys = LinkingObjects(fromType: ENUser.self, property: "casesCreated")
	var updatedBy: ENUser? {
		return self.updatedBys.first
	}

	//MARK: - One-to-many relationships
	let files =  LinkingObjects(fromType: ENFile.self, property: "userCase")
	let messages =  LinkingObjects(fromType: ENChatMessage.self, property: "userCase")

	//MARK: - Many-to-many relationships
	let selectedTags =  LinkingObjects(fromType: ENTag.self, property: "cases")

}
