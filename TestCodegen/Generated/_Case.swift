//
// _Case.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Case: _Object {

	let age: Int?
	let agePeriod: Int?
	let arrivedAt: Date?
	let beganAt: Date?
	let caseNumber: Int?
	let channelId: String?
	let closedAt: Date?
	let gender: String?
	let id: String
	let complaint: Complaint?
	let createdBy: User
	let destinationHospital: Hospital?
	let emsAgency: EMSAgency
	let files: [File]?
	let messages: [ChatMessage]?
	let queue: CaseQueue?
	let selectedTags: [Tag]?
	let truck: Truck
	let updatedBy: User?

	init(age: Int?, agePeriod: Int?, arrivedAt: Date?, beganAt: Date?, caseNumber: Int?, channelId: String?, closedAt: Date?, complaint: Complaint?, createdAt: Date, createdBy: User, destinationHospital: Hospital?, emsAgency: EMSAgency, files: [File]?, gender: String?, id: String, localUpdatedAt: Date, messages: [ChatMessage]?, queue: CaseQueue?, selectedTags: [Tag]?, truck: Truck, updatedAt: Date?, updatedBy: User?) {
		self.age = age
		self.agePeriod = agePeriod
		self.arrivedAt = arrivedAt
		self.beganAt = beganAt
		self.caseNumber = caseNumber
		self.channelId = channelId
		self.closedAt = closedAt
		self.complaint = complaint
		self.createdBy = createdBy
		self.destinationHospital = destinationHospital
		self.emsAgency = emsAgency
		self.files = files
		self.gender = gender
		self.id = id
		self.messages = messages
		self.queue = queue
		self.selectedTags = selectedTags
		self.truck = truck
		self.updatedBy = updatedBy
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let age: String = "age"
		static let agePeriod: String = "agePeriod"
		static let arrivedAt: String = "arrivedAt"
		static let beganAt: String = "beganAt"
		static let caseNumber: String = "caseNumber"
		static let channelId: String = "channelId"
		static let closedAt: String = "closedAt"
		static let gender: String = "gender"
		static let id: String = "id"
		static let complaint: String = "complaint"
		static let createdBy: String = "createdBy"
		static let destinationHospital: String = "destinationHospital"
		static let emsAgency: String = "emsAgency"
		static let files: String = "files"
		static let messages: String = "messages"
		static let queue: String = "queue"
		static let selectedTags: String = "selectedTags"
		static let truck: String = "truck"
		static let updatedBy: String = "updatedBy"
	}
}

func ==(lhs: Case, rhs: Case) -> Bool {
	return lhs.age == rhs.age && lhs.agePeriod == rhs.agePeriod && lhs.arrivedAt == rhs.arrivedAt && lhs.beganAt == rhs.beganAt && lhs.caseNumber == rhs.caseNumber && lhs.channelId == rhs.channelId && lhs.closedAt == rhs.closedAt && lhs.gender == rhs.gender && lhs.id == rhs.id && lhs.complaint == rhs.complaint && lhs.createdBy == rhs.createdBy && lhs.destinationHospital == rhs.destinationHospital && lhs.emsAgency == rhs.emsAgency && lhs.files == rhs.files && lhs.messages == rhs.messages && lhs.queue == rhs.queue && lhs.selectedTags == rhs.selectedTags && lhs.truck == rhs.truck && lhs.updatedBy == rhs.updatedBy 
}

func ==(lhs: Case?, rhs: Case?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Case]?, rhs: [Case]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
