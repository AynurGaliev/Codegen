//
// ENTWCase.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWCase: ENTWObject {

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
	dynamic var complaint: ENTWComplaint?
	dynamic var createdBy: ENTWUser?
	dynamic var destinationHospital: ENTWHospital?
	dynamic var emsAgency: ENTWEMSAgency?
	dynamic var queue: ENTWCaseQueue?
	dynamic var truck: ENTWTruck?
	dynamic var updatedBy: ENTWUser?

	//MARK: - One-to-many relationships
	let files = List<ENTWFile>()
	let messages = List<ENTWChatMessage>()
	let selectedTags = List<ENTWTag>()

}
