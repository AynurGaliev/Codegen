//
// CaseSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

let MAX_SERIALIZATION_DEPTH: Int = 3

protocol ICaseSerializer: class {
	func serialize(enCase: ENCase?, depth: Int) -> Case?
	func serialize(enCases: [ENCase], depth: Int) -> [Case]
	var complaintSerializer: IComplaintSerializer! { get set }
	var userSerializer: IUserSerializer! { get set }
	var hospitalSerializer: IHospitalSerializer! { get set }
	var eMSAgencySerializer: IEMSAgencySerializer! { get set }
	var fileSerializer: IFileSerializer! { get set }
	var chatMessageSerializer: IChatMessageSerializer! { get set }
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
	var tagSerializer: ITagSerializer! { get set }
	var truckSerializer: ITruckSerializer! { get set }
}

final class CaseSerializer: ICaseSerializer {

	//MARK: - Dependencies
	var complaintSerializer: IComplaintSerializer!
	var userSerializer: IUserSerializer!
	var hospitalSerializer: IHospitalSerializer!
	var eMSAgencySerializer: IEMSAgencySerializer!
	var fileSerializer: IFileSerializer!
	var chatMessageSerializer: IChatMessageSerializer!
	var caseQueueSerializer: ICaseQueueSerializer!
	var tagSerializer: ITagSerializer!
	var truckSerializer: ITruckSerializer!

	func serialize(enCase: ENCase?, depth: Int) -> Case? {

		guard let lCase = enCase else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let age = lCase.age.value
		let agePeriod = lCase.agePeriod.value
		let arrivedAt = lCase.arrivedAt
		let beganAt = lCase.beganAt
		let caseNumber = lCase.caseNumber.value
		let channelId = lCase.channelId
		let closedAt = lCase.closedAt
		let createdAt = lCase.createdAt
		let gender = lCase.gender
		let id = lCase.id
		let localUpdatedAt = lCase.localUpdatedAt
		let updatedAt = lCase.updatedAt

		//MARK: - Serializing relationships
		let complaint = self.complaintSerializer.serialize(enComplaint: lCase.complaint, depth: maxDepth - 1)
		let createdBy = self.userSerializer.serialize(enUser: lCase.createdBy, depth: maxDepth - 1)!
		let destinationHospital = self.hospitalSerializer.serialize(enHospital: lCase.destinationHospital, depth: maxDepth - 1)
		let emsAgency = self.eMSAgencySerializer.serialize(enEMSAgency: lCase.emsAgency, depth: maxDepth - 1)!
		let files = self.fileSerializer.serialize(enFiles: Array(lCase.files), depth: maxDepth - 1)
		let messages = self.chatMessageSerializer.serialize(enChatMessages: Array(lCase.messages), depth: maxDepth - 1)
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lCase.queue, depth: maxDepth - 1)
		let selectedTags = self.tagSerializer.serialize(enTags: Array(lCase.selectedTags), depth: maxDepth - 1)
		let truck = self.truckSerializer.serialize(enTruck: lCase.truck, depth: maxDepth - 1)!
		let updatedBy = self.userSerializer.serialize(enUser: lCase.updatedBy, depth: maxDepth - 1)

		return Case(age: age, agePeriod: agePeriod, arrivedAt: arrivedAt, beganAt: beganAt, caseNumber: caseNumber, channelId: channelId, closedAt: closedAt, complaint: complaint, createdAt: createdAt, createdBy: createdBy, destinationHospital: destinationHospital, emsAgency: emsAgency, files: files, gender: gender, id: id, localUpdatedAt: localUpdatedAt, messages: messages, queue: queue, selectedTags: selectedTags, truck: truck, updatedAt: updatedAt, updatedBy: updatedBy)
	}

	func serialize(enCases: [ENCase], depth: Int) -> [Case] {

		guard enCases.count != 0 else { return [] }
		var serializedCases: [Case] = []
		for value in enCases {
			guard let entity = self.serialize(enCase: value, depth: depth) else { continue }
			serializedCases.append(entity)
		}
		return serializedCases
	}
}
