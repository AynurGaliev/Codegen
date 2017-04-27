//
// ComplaintSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IComplaintSerializer: class {
	func serialize(enComplaint: ENComplaint?, depth: Int) -> Complaint?
	func serialize(enComplaints: [ENComplaint], depth: Int) -> [Complaint]
	var caseSerializer: ICaseSerializer! { get set }
	var tagSerializer: ITagSerializer! { get set }
}

final class ComplaintSerializer: IComplaintSerializer {

	//MARK: - Dependencies
	var caseSerializer: ICaseSerializer!
	var tagSerializer: ITagSerializer!

	func serialize(enComplaint: ENComplaint?, depth: Int) -> Complaint? {

		guard let lComplaint = enComplaint else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let archived = lComplaint.archived
		let complaintSet = lComplaint.complaintSet
		let createdAt = lComplaint.createdAt
		let id = lComplaint.id
		let localUpdatedAt = lComplaint.localUpdatedAt
		let name = lComplaint.name
		let order = lComplaint.order.value
		let priority = lComplaint.priority
		let showInterventions = lComplaint.showInterventions
		let showOnsets = lComplaint.showOnsets
		let showSymptoms = lComplaint.showSymptoms
		let showVitals = lComplaint.showVitals
		let updatedAt = lComplaint.updatedAt

		//MARK: - Serializing relationships
		let cases = self.caseSerializer.serialize(enCases: Array(lComplaint.cases), depth: maxDepth - 1)
		let tags = self.tagSerializer.serialize(enTags: Array(lComplaint.tags), depth: maxDepth - 1)

		return Complaint(archived: archived, cases: cases, complaintSet: complaintSet, createdAt: createdAt, id: id, localUpdatedAt: localUpdatedAt, name: name, order: order, priority: priority, showInterventions: showInterventions, showOnsets: showOnsets, showSymptoms: showSymptoms, showVitals: showVitals, tags: tags, updatedAt: updatedAt)
	}

	func serialize(enComplaints: [ENComplaint], depth: Int) -> [Complaint] {

		guard enComplaints.count != 0 else { return [] }
		var serializedComplaints: [Complaint] = []
		for value in enComplaints {
			guard let entity = self.serialize(enComplaint: value, depth: depth) else { continue }
			serializedComplaints.append(entity)
		}
		return serializedComplaints
	}
}
