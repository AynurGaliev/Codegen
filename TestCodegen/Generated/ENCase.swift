//
// ENCase.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
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

	//MARK: - Relationships
	dynamic var complaint: ENComplaint?
	dynamic var createdBy: ENUser?
	dynamic var destinationHospital: ENHospital?
	dynamic var emsAgency: ENEMSAgency?
	let files = List<ENFile>()
	let messages = List<ENChatMessage>()
	dynamic var queue: ENCaseQueue?
	let selectedTags = List<ENTag>()
	dynamic var truck: ENTruck?
	dynamic var updatedBy: ENUser?

}
