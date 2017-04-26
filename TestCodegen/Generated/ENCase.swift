//
// ENCase.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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
	dynamic var complaint: ENComplaint?
	dynamic var createdBy: ENUser?
	dynamic var destinationHospital: ENHospital?
	dynamic var emsAgency: ENEMSAgency?
	private let queues = LinkingObjects(fromType: ENCaseQueue.self, property: "queueCase")
	var queue: ENCaseQueue? {
		return self.queues.first
	}
	dynamic var truck: ENTruck?
	dynamic var updatedBy: ENUser?

	//MARK: - One-to-many relationships
	let files = LinkingObjects(fromType: ENFile.self, property: "userCase")
	let messages = LinkingObjects(fromType: ENChatMessage.self, property: "userCase")
	let selectedTags =  LinkingObjects(fromType: ENTag.self, property: "cases")

}
